import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:symmetryproject/core/utils/app_colors.dart';
import 'package:symmetryproject/features/articles/presentation/widgets/image_picker_button.dart';
import 'package:symmetryproject/injection.dart' as di;
import '../bloc/add_article_bloc.dart';
import '../bloc/add_article_event.dart';
import '../bloc/add_article_state.dart';

class AddArticlePage extends StatelessWidget {
  const AddArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddArticleBloc(di.getIt()),
      child: const AddArticleView(),
    );
  }
}

class AddArticleView extends StatefulWidget {
  const AddArticleView({super.key});

  @override
  State<AddArticleView> createState() => _AddArticleViewState();
}

class _AddArticleViewState extends State<AddArticleView> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  File? _selectedImage;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
   void _unfocusKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _publishArticle(BuildContext context) {
    _unfocusKeyboard();
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    //  validation
    if (title.isEmpty) {
      _showError('Please enter a title');
      return;
    }

    if (title.length < 5) {
      _showError('Title must be at least 5 characters');
      return;
    }

    if (content.isEmpty) {
      _showError('Please enter article content');
      return;
    }

    if (content.length < 20) {
      _showError('Content must be at least 20 characters');
      return;
    }

    if (_selectedImage == null) {
      _showError('Please select an image');
      return;
    }

    context.read<AddArticleBloc>().add(
      PublishArticle(
        title: title,
        content: content,
        image: _selectedImage!,
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddArticleBloc, AddArticleState>(
      listener: (context, state) {
        if (state is AddArticleSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Article published successfully!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
          Navigator.pop(context, true);
        } else if (state is AddArticleError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AddArticleLoading;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: GestureDetector(
            onTap: _unfocusKeyboard,
            child: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      _buildHeader(context),
                      Expanded(
                        child: _buildForm(context),
                      ),
                    ],
                  ),
                  if (isLoading)
                    Container(
                      color: Colors.black54,
                      child: const Center(
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 16),
                                Text('Publishing article...'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: _buildPublishButton(context, isLoading),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_left),
            onPressed:  () {
              _unfocusKeyboard(); 
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        TextField(
          controller: _titleController,
          minLines: 3,
          maxLines: 5,
          maxLength: 200,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: 'Write your title here...',
            hintStyle: TextStyle(
              color: AppColors.textSecondary.withOpacity(0.5),
              fontSize: 16,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: AppColors.border, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: AppColors.border, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        ImagePickerButton(
          selectedImage: _selectedImage,
          onImageSelected: (File? image) {
            setState(() => _selectedImage = image);
          },
           onButtonPressed: _unfocusKeyboard,
        ),
        const SizedBox(height: 24),
        
        TextField(
          controller: _contentController,
          minLines: 10,
          maxLines: 20,
          maxLength: 50000,
          keyboardType: TextInputType.multiline,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: 'Add article here...',
            hintStyle: TextStyle(
              color: AppColors.textSecondary.withOpacity(0.5),
              fontSize: 16,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: AppColors.border, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: AppColors.border, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildPublishButton(BuildContext context, bool isLoading) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(color: AppColors.primary),
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          onPressed: isLoading ? null : () => _publishArticle(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textPrimary,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.login, size: 24),
              SizedBox(width: 12),
              Text(
                'Publish Article',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}