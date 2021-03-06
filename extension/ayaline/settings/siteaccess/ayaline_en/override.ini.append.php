<?php /* #?ini charset="utf-8"?

	#ayaline

[newsletters_reponse]
Source=content/collectedinfo/form.tpl
MatchFile=full/newsletters_reponse.tpl
Subdir=templates
Match[class_identifier]=newsletters

[full_newsletters]
Source=node/view/full.tpl
MatchFile=full/newsletters.tpl
Subdir=templates
Match[class_identifier]=newsletters

[mail_newsletters]
Source=content/collectedinfomail/form.tpl
MatchFile=full/mail_newsletters.tpl
Subdir=templates
Match[class_identifier]=newsletters

	#Phototheque

[file_embed]
Source=content/view/embed.tpl
MatchFile=embed/file.tpl
Subdir=templates
Match[class_identifier]=file

[line_album_phototheque]
Source=node/view/line.tpl
MatchFile=line/album_phototheque.tpl
Subdir=templates
Match[class_identifier]=album_phototheque

[line_dossier_phototheque]
Source=node/view/line.tpl
MatchFile=line/dossier_phototheque.tpl
Subdir=templates
Match[class_identifier]=dossier_phototheque

[full_album_phototheque]
Source=node/view/full.tpl
MatchFile=full/album_phototheque.tpl
Subdir=templates
Match[class_identifier]=album_phototheque

[full_dossier_phototheque]
Source=node/view/full.tpl
MatchFile=full/dossier_phototheque.tpl
Subdir=templates
Match[class_identifier]=dossier_phototheque

[full_phototheque]
Source=node/view/full.tpl
MatchFile=full/phototheque.tpl
Subdir=templates
Match[class_identifier]=phototheque

[full_espace_presse]
Source=node/view/full.tpl
MatchFile=full/espace_presse.tpl
Subdir=templates
Match[class_identifier]=espace_presse

	#Fin Phototheque

[embed_content_sit_mise_en_avant]
Source=content/view/embed.tpl
MatchFile=embed/content/sit_mise_en_avant.tpl
Subdir=templates
Match[class_identifier]=sit_mise_en_avant

[embed_node_sit_mise_en_avant]
Source=node/view/embed.tpl
MatchFile=embed/node/sit_mise_en_avant.tpl
Subdir=templates
Match[class_identifier]=sit_mise_en_avant

[full_itineraire]
Source=node/view/full.tpl
MatchFile=full/itineraire.tpl
Subdir=templates
Match[class_identifier]=itineraire

[line_sit_liste]
Source=node/view/line.tpl
MatchFile=line/sit_liste.tpl
Subdir=templates
Match[class_identifier]=sit_liste

[full_sit_liste]
Source=node/view/full.tpl
MatchFile=full/sit_liste.tpl
Subdir=templates
Match[class_identifier]=sit_liste

[full_contact]
Source=node/view/full.tpl
MatchFile=full/page_contact.tpl
Subdir=templates
Match[class_identifier]=page_contact

[mail_contact]
Source=content/collectedinfomail/form.tpl
MatchFile=full/collectedinfomail.tpl
Subdir=templates
Match[class_identifier]=page_contact

[contact_reponse]
Source=content/collectedinfo/form.tpl
MatchFile=full/contact_reponse.tpl
Subdir=templates
Match[class_identifier]=page_contact

[full_survey]
Source=node/view/full.tpl
MatchFile=full/survey.tpl
Subdir=templates
Match[class_identifier]=survey

[full_sitemap_list]
Source=node/view/full.tpl
MatchFile=full/sitemap_list.tpl
Subdir=templates
Match[class_identifier]=site_map

		#Mediatheque

[full_detail_video]
Source=node/view/full.tpl
MatchFile=full/ayaline_video.tpl
Subdir=templates
Match[class_identifier]=gallery_video

[full_ayaline_gallery]
Source=node/view/full.tpl
MatchFile=full/ayaline_gallery.tpl
Subdir=templates
Match[class_identifier]=ayaline_gallery

[full_ayaline_gallery_video]
Source=node/view/full.tpl
MatchFile=full/ayaline_gallery_video.tpl
Subdir=templates
Match[class_identifier]=gallery_category_video

[full_ayaline_gallery_photo]
Source=node/view/full.tpl
MatchFile=full/ayaline_gallery_photo.tpl
Subdir=templates
Match[class_identifier]=gallery_category_photo

[full_gallery_gallery_photo]
Source=node/view/full.tpl
MatchFile=full/ayaline_gallery_gallery_photo.tpl
Subdir=templates
Match[class_identifier]=gallery_gallery_photo

		#Fin Mediatheque

[line_brochure]
Source=node/view/line.tpl
MatchFile=line/brochure.tpl
Subdir=templates
Match[class_identifier]=brochure

[full_brochures]
Source=node/view/full.tpl
MatchFile=full/brochures_list.tpl
Subdir=templates
Match[class_identifier]=brochures

[grouped_faq]
Source=node/view/line.tpl
MatchFile=line/faq_view_grouped.tpl
Subdir=templates
Match[class_identifier]=faq

[line_faq]
Source=node/view/line.tpl
MatchFile=line/faq_view_list.tpl
Subdir=templates
Match[class_identifier]=faq

[full_faqs]
Source=node/view/full.tpl
MatchFile=full/faq_list_view_full.tpl
Subdir=templates
Match[class_identifier]=faqs

[blocsAccueil_ba_flux_rss_blog]
Source=node/view/blocsAccueil.tpl
MatchFile=blocsAccueil/ba_flux_rss_blog.tpl
Subdir=templates
Match[class_identifier]=ba_flux_rss_blog

[blocsAccueil_simple_free_content]
Source=node/view/blocsAccueil.tpl
MatchFile=blocsAccueil/simple_free_content.tpl
Subdir=templates
Match[class_identifier]=simple_free_content

[blocsAccueil_embed_code]
Source=node/view/blocsAccueil.tpl
MatchFile=blocsAccueil/embed_code.tpl
Subdir=templates
Match[class_identifier]=embed_code

[line_rubric]
Source=node/view/line.tpl
MatchFile=line/rubric.tpl
Subdir=templates
Match[class_identifier]=rubric

[full_rubric]
Source=node/view/full.tpl
MatchFile=full/rubric.tpl
Subdir=templates
Match[class_identifier]=rubric

[full_home]
Source=node/view/full.tpl
MatchFile=full/home.tpl
Subdir=templates
Match[class_identifier]=home

		#Navigation
	
[menu_lien_externe]
Source=node/view/menu.tpl
MatchFile=menu/lien_externe.tpl
Subdir=templates
Match[class_identifier]=lien_externe
	
[menu_simple_free_content]
Source=node/view/menu.tpl
MatchFile=menu/simple_free_content.tpl
Subdir=templates
Match[class_identifier]=simple_free_content

[menu_embed_code]
Source=node/view/menu.tpl
MatchFile=menu/embed_code.tpl
Subdir=templates
Match[class_identifier]=embed_code

[menu_sub_menu]
Source=node/view/menu.tpl
MatchFile=menu/sub_menu.tpl
Subdir=templates
Match[class_identifier]=sub_menu

[main_menu_sit_liste]
Source=node/view/main_menu.tpl
MatchFile=main_menu/sit_liste.tpl
Subdir=templates
Match[class_identifier]=sit_liste

[main_menu_rubric]
Source=node/view/main_menu.tpl
MatchFile=main_menu/rubric.tpl
Subdir=templates
Match[class_identifier]=rubric

[main_focus_menu_sit_mise_en_avant]
Source=node/view/main_focus_menu.tpl
MatchFile=main_focus_menu/sit_mise_en_avant.tpl
Subdir=templates
Match[class_identifier]=sit_mise_en_avant

[main_focus_menu_main_menu]
Source=node/view/main_focus_menu.tpl
MatchFile=main_focus_menu/main_menu.tpl
Subdir=templates
Match[class_identifier]=main_menu

[main_focus_menu_embed_code]
Source=node/view/main_focus_menu.tpl
MatchFile=main_focus_menu/embed_code.tpl
Subdir=templates
Match[class_identifier]=embed_code

[full_left_menu_rubric]
Source=node/view/full_left_menu.tpl
MatchFile=full_left_menu/rubric.tpl
Subdir=templates
Match[class_identifier]=rubric

[line_topic]
Source=node/view/line.tpl
MatchFile=line/topic.tpl
Subdir=templates
Match[class_identifier]=topic
	
	#config initiale

[full_folder]
Source=node/view/full.tpl
MatchFile=full/folder.tpl
Subdir=templates
Match[class_identifier]=folder

[line_folder]
Source=node/view/line.tpl
MatchFile=line/folder.tpl
Subdir=templates
Match[class_identifier]=folder

[embed_folder_list]
Source=content/view/embed.tpl
MatchFile=embed/folder_list.tpl
Subdir=templates
Match[class_identifier]=folder
Match[classification]=list

[embed_folder_subtree]
Source=content/view/embed.tpl
MatchFile=embed/folder_subtree.tpl
Subdir=templates
Match[class_identifier]=folder
Match[classification]=subtreelist

[embed_folder_contentlist]
Source=content/view/embed.tpl
MatchFile=embed/folder_contentlist.tpl
Subdir=templates
Match[class_identifier]=folder

[edit_user]
Source=content/edit.tpl
MatchFile=edit/user.tpl
Subdir=templates
Match[class_identifier]=user

[article_full]
Source=node/view/full.tpl
MatchFile=full/article.tpl
Subdir=templates
Match[class_identifier]=article

[article_line]
Source=node/view/line.tpl
MatchFile=line/article.tpl
Subdir=templates
Match[class_identifier]=article

[article_listitem]
Source=node/view/listitem.tpl
MatchFile=listitem/article.tpl
Subdir=templates
Match[class_identifier]=article

[article_embed]
Source=content/view/embed.tpl
MatchFile=embed/article.tpl
Subdir=templates
Match[class_identifier]=article

[class_image]
Source=content/datatype/view/ezobjectrelation.tpl
MatchFile=datatype/ezobjectrelation/image.tpl
Subdir=templates
Match[class_identifier]=article

[full_comment]
Source=node/view/full.tpl
MatchFile=full/comment.tpl
Subdir=templates
Match[class]=13

[line_comment]
Source=node/view/line.tpl
MatchFile=line/comment.tpl
Subdir=templates
Match[class_identifier]=comment

[edit_comment]
Source=content/edit.tpl
MatchFile=edit/comment.tpl
Subdir=templates
Match[class_identifier]=comment

[file_full]
Source=node/view/full.tpl
MatchFile=full/file.tpl
Subdir=templates
Match[class_identifier]=file

[file_line]
Source=node/view/line.tpl
MatchFile=line/file.tpl
Subdir=templates
Match[class_identifier]=file

[edit_file]
Source=content/edit.tpl
MatchFile=edit/file.tpl
Subdir=templates
Match[class_identifier]=file

[embed_file]
Source=content/view/embed.tpl
MatchFile=embed/file.tpl
Subdir=templates
Match[class_identifier]=file

[file_listitem]
Source=node/view/listitem.tpl
MatchFile=listitem/file.tpl
Subdir=templates
Match[class_identifier]=file

[file_binaryfile]
Source=content/datatype/view/ezbinaryfile.tpl
MatchFile=datatype/ezbinaryfile.tpl
Subdir=templates

[full_link]
Source=node/view/full.tpl
MatchFile=full/link.tpl
Subdir=templates
Match[class_identifier]=link

[listitem_link]
Source=node/view/listitem.tpl
MatchFile=listitem/link.tpl
Subdir=templates
Match[class_identifier]=link

[line_link]
Source=node/view/line.tpl
MatchFile=line/link.tpl
Subdir=templates
Match[class_identifier]=link

[image_full]
Source=node/view/full.tpl
MatchFile=full/image.tpl
Subdir=templates
Match[class_identifier]=image

[image_line]
Source=node/view/line.tpl
MatchFile=line/image.tpl
Subdir=templates
Match[class_identifier]=image

[image_galleryline]
Source=node/view/galleryline.tpl
MatchFile=galleryline/image.tpl
Subdir=templates
Match[class_identifier]=image

[image_galleryslide]
Source=node/view/galleryslide.tpl
MatchFile=galleryslide/image.tpl
Subdir=templates
Match[class_identifier]=image

[image_listitem]
Source=node/view/listitem.tpl
MatchFile=listitem/image.tpl
Subdir=templates
Match[class_identifier]=image

[image_embed]
Source=content/view/embed.tpl
MatchFile=embed/image.tpl
Subdir=templates
Match[class_identifier]=image

[image_embed-inline]
Source=content/view/embed-inline.tpl
MatchFile=embed-inline/image.tpl
Subdir=templates
Match[class_identifier]=image

[image_embed_node]
Source=node/view/embed.tpl
MatchFile=embed/image.tpl
Subdir=templates
Match[class_identifier]=image

[image_embed-inline_node]
Source=node/view/embed-inline.tpl
MatchFile=embed-inline/image.tpl
Subdir=templates
Match[class_identifier]=image

[text_linked_image]
Source=content/view/text_linked.tpl
MatchFile=textlinked/image.tpl
Subdir=templates
Match[class]=5

[flash_full]
Source=node/view/full.tpl
MatchFile=full/flash.tpl
Subdir=templates
Match[class_identifier]=flash

[flash_line]
Source=node/view/line.tpl
MatchFile=line/flash.tpl
Subdir=templates
Match[class_identifier]=flash

[embed_flash]
Source=content/view/embed.tpl
MatchFile=embed/flash.tpl
Subdir=templates
Match[class_identifier]=flash

[quicktime_full]
Source=node/view/full.tpl
MatchFile=full/quicktime.tpl
Subdir=templates
Match[class_identifier]=quicktime

[quicktime_line]
Source=node/view/line.tpl
MatchFile=line/quicktime.tpl
Subdir=templates
Match[class_identifier]=quicktime

[embed_quicktime]
Source=content/view/embed.tpl
MatchFile=embed/quicktime.tpl
Subdir=templates
Match[class_identifier]=quicktime

[windows_media_full]
Source=node/view/full.tpl
MatchFile=full/windows_media.tpl
Subdir=templates
Match[class_identifier]=windows_media

[windows_media_line]
Source=node/view/line.tpl
MatchFile=line/windows_media.tpl
Subdir=templates
Match[class_identifier]=windows_media

[embed_windows_media]
Source=content/view/embed.tpl
MatchFile=embed/windows_media.tpl
Subdir=templates
Match[class_identifier]=windows_media

[real_video_full]
Source=node/view/full.tpl
MatchFile=full/real_video.tpl
Subdir=templates
Match[class_identifier]=real_video

[real_video_line]
Source=node/view/line.tpl
MatchFile=line/real_video.tpl
Subdir=templates
Match[class_identifier]=real_video

[embed_real_video]
Source=content/view/embed.tpl
MatchFile=embed/real_video.tpl
Subdir=templates
Match[class_identifier]=real_video

[forum_full]
Source=node/view/full.tpl
MatchFile=full/forum.tpl
Subdir=templates
Match[class_identifier]=forum

[forum_line]
Source=node/view/line.tpl
MatchFile=line/forum.tpl
Subdir=templates
Match[class_identifier]=forum

[forum_embed]
Source=content/view/embed.tpl
MatchFile=embed/forum.tpl
Subdir=templates
Match[class_identifier]=forum

[forum_topic_edit]
Source=content/edit.tpl
MatchFile=edit/forum_topic.tpl
Subdir=templates
Match[class_identifier]=forum_topic

[forum_topic_full]
Source=node/view/full.tpl
MatchFile=full/forum_topic.tpl
Subdir=templates
Match[class_identifier]=forum_topic

[forum_topic_line]
Source=node/view/line.tpl
MatchFile=line/forum_topic.tpl
Subdir=templates
Match[class_identifier]=forum_topic

[forum_topic_listitem]
Source=node/view/listitem.tpl
MatchFile=listitem/forum_topic.tpl
Subdir=templates
Match[class_identifier]=forum_topic

[forum_reply_full]
Source=node/view/full.tpl
MatchFile=full/forum_reply.tpl
Subdir=templates
Match[class_identifier]=forum_reply

[forum_reply_line]
Source=node/view/line.tpl
MatchFile=line/forum_reply.tpl
Subdir=templates
Match[class_identifier]=forum_reply

[forum_reply_edit]
Source=content/edit.tpl
MatchFile=edit/forum_reply.tpl
Subdir=templates
Match[class_identifier]=forum_reply

[weblog_full]
Source=node/view/full.tpl
MatchFile=full/weblog.tpl
Subdir=templates
Match[class_identifier]=weblog

[weblog_line]
Source=node/view/line.tpl
MatchFile=line/weblog.tpl
Subdir=templates
Match[class_identifier]=weblog

[weblog_edit]
Source=content/edit.tpl
MatchFile=edit/weblog.tpl
Subdir=templates
Match[class_identifier]=weblog

[product_full]
Source=node/view/full.tpl
MatchFile=full/product.tpl
Subdir=templates
Match[class_identifier]=product

[product_line]
Source=node/view/line.tpl
MatchFile=line/product.tpl
Subdir=templates
Match[class_identifier]=product

[product_embed]
Source=content/view/embed.tpl
MatchFile=embed/product.tpl
Subdir=templates
Match[class_identifier]=product

[product_listitem]
Source=node/view/listitem.tpl
MatchFile=listitem/product.tpl
Subdir=templates
Match[class_identifier]=product

[review_line]
Source=node/view/line.tpl
MatchFile=line/review.tpl
Subdir=templates
Match[class_identifier]=review

[review_edit]
Source=content/edit.tpl
MatchFile=edit/review.tpl
Subdir=templates
Match[class_identifier]=review

[gallery_full]
Source=node/view/full.tpl
MatchFile=full/gallery.tpl
Subdir=templates
Match[class_identifier]=gallery

[gallery_slideshow]
Source=node/view/slideshow.tpl
MatchFile=slideshow/gallery.tpl
Subdir=templates
Match[class_identifier]=gallery

[gallery_line]
Source=node/view/line.tpl
MatchFile=line/gallery.tpl
Subdir=templates
Match[class_identifier]=gallery

[gallery_embed]
Source=content/view/embed.tpl
MatchFile=embed/gallery.tpl
Subdir=templates
Match[class_identifier]=gallery

[poll_full]
Source=node/view/full.tpl
MatchFile=full/poll.tpl
Subdir=templates
Match[class_identifier]=poll

[poll_line]
Source=node/view/line.tpl
MatchFile=line/poll.tpl
Subdir=templates
Match[class_identifier]=poll

[poll_embed]
Source=content/view/embed.tpl
MatchFile=embed/poll.tpl
Subdir=templates
Match[class_identifier]=poll

[poll_result]
Source=content/collectedinfo/poll.tpl
MatchFile=collectedinfo/poll_result.tpl
Subdir=templates

[person_full]
Source=node/view/full.tpl
MatchFile=full/person.tpl
Subdir=templates
Match[class_identifier]=person

[person_line]
Source=node/view/line.tpl
MatchFile=line/person.tpl
Subdir=templates
Match[class_identifier]=person

[person_embed]
Source=content/view/embed.tpl
MatchFile=embed/person.tpl
Subdir=templates
Match[class_identifier]=person

[edit_person]
Source=content/edit.tpl
MatchFile=edit/person.tpl
Subdir=templates
Match[class_identifier]=person

[company_full]
Source=node/view/full.tpl
MatchFile=full/company.tpl
Subdir=templates
Match[class_identifier]=company

[company_line]
Source=node/view/line.tpl
MatchFile=line/company.tpl
Subdir=templates
Match[class_identifier]=company

[company_embed]
Source=content/view/embed.tpl
MatchFile=embed/company.tpl
Subdir=templates
Match[class_identifier]=company

[edit_company]
Source=content/edit.tpl
MatchFile=edit/company.tpl
Subdir=templates
Match[class_identifier]=company

[feedback_form_full]
Source=node/view/full.tpl
MatchFile=full/feedback_form.tpl
Subdir=templates
Match[class_identifier]=feedback_form

[feedback_form_line]
Source=node/view/line.tpl
MatchFile=line/feedback_form.tpl
Subdir=templates
Match[class_identifier]=feedback_form

[feedback_form_mail]
Source=content/collectedinfomail/form.tpl
MatchFile=collectedinfomail/feedback_form.tpl
Subdir=templates
Match[class_identifier]=feedback_form

[factbox]
Source=content/datatype/view/ezxmltags/factbox.tpl
MatchFile=datatype/ezxmltext/factbox.tpl
Subdir=templates

[quote]
Source=content/datatype/view/ezxmltags/quote.tpl
MatchFile=datatype/ezxmltext/quote.tpl
Subdir=templates

[price]
Source=content/datatype/view/ezprice.tpl
MatchFile=datatype/price.tpl
Subdir=templates

[matrix]
Source=content/datatype/view/ezmatrix.tpl
MatchFile=datatype/ezmatrix/view.tpl
Subdir=templates

[edit_matrix]
Source=content/datatype/edit/ezmatrix.tpl
MatchFile=datatype/ezmatrix/edit.tpl
Subdir=templates

[pdf_article_main]
Source=node/view/pdf.tpl
MatchFile=pdf/article/main.tpl
Match[class_identifier]=article
Subdir=templates

[pdf_article_title]
Source=content/datatype/pdf/ezstring.tpl
MatchFile=pdf/article/title.tpl
Match[class_identifier]=article
Match[attribute_identifier]=title
Subdir=templates

[pdf_article_author]
Source=content/datatype/pdf/ezauthor.tpl
MatchFile=pdf/article/author.tpl
Match[class_identifier]=article
Match[attribute_identifier]=author
Subdir=templates

[pdf_article_xml_headers]
Source=content/datatype/pdf/ezxmltags/header.tpl
MatchFile=pdf/article/xml_header.tpl
Match[class_identifier]=article
Subdir=templates

[pdf_article_xml_paragraph]
Source=content/datatype/pdf/ezxmltags/paragraph.tpl
MatchFile=pdf/article/xml_paragraph.tpl
Match[class_identifier]=article
Subdir=templates

[pdf_article_footer]
Source=content/pdf/footer.tpl
MatchFile=pdf/article/footer.tpl
Match[class_identifier]=article
Subdir=templates

[pdf_article_embed_image]
Source=content/pdf/embed.tpl
MatchFile=pdf/article/image.tpl
Match[class_identifier]=article
Subdir=templates

[tiny_image]
Source=content/view/tiny.tpl
MatchFile=tiny_image.tpl
Subdir=templates
Match[class_identifier]=image

[embed_embed_code]
Source=content/view/embed.tpl
MatchFile=embed/content/embed_code.tpl
Subdir=templates
Match[class_identifier]=embed_code
*/ ?>