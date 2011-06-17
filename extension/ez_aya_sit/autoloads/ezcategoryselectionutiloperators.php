<?php
//
// Definition of eZCategorySelectionUtil class
//
// Created on: <2-Sep-2006 21:00:27 GTM+8>
//
// SOFTWARE NAME: 
// SOFTWARE RELEASE: 
// BUILD VERSION: 
// COPYRIGHT NOTICE: Copyright (C) 1999-2006 ZERUS TECHNOLOGY LTD (http://www.zerustech.com) AS
// SOFTWARE LICENSE: GNU General Public License v2.0
// NOTICE: >
//   This program is free software; you can redistribute it and/or
//   modify it under the terms of version 2.0  of the GNU General
//   Public License as published by the Free Software Foundation.
// 
//   This program is distributed in the hope that it will be useful,
//   but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//   GNU General Public License for more details.
// 
//   You should have received a copy of version 2.0 of the GNU General
//   Public License along with this program; if not, write to the Free
//   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
//   MA 02110-1301, USA.
//
//

//require_once('lib/ezxml/classes/ezxml.php');
//require_once('kernel/classes/ezcontentobjectattribute.php');
//require_once('kernel/classes/ezcontentclassattribute.php');
//require_once('kernel/classes/ezcontentclass.php');
require_once('extension/ez_aya_sit/datatypes/ezcategoryselection/ezcategoryselectiontype.php');

class eZCategorySelectionUtil{

	var $Operators;

	function eZCategorySelectionUtil(){

		$this->Operators = array (
			'option_filter',
			'category_options',
			'object_category_options',
			'object_category_values',
			'has_related_category_options',
			'category_option_array',
			'category_option_simple_array',
			'thresholds',
			'generate_category_string',
			'is_empty_category',
			'category_option_values',
			'inarray'
		);

	}

	function &operatorList(){

		return $this->Operators;

	}

	function namedParameterPerOperator(){

		return true;

	}

	function namedParameterList(){

		return array( 'option_filter'=>array('content_object_attribute_id'=>
						     array('type'=>'integer',
							   'required'=>true,
								   'default'=>0)),
				  'category_options'=>array('content_class_attribute_id'=>
							array('type'=>'integer',
							'required'=>true,
							'default'=>0),
							'category_array'=>
						array('type'=>'array',
							'required'=>false,
							'default'=>null), 
							'version_id'=>
						array('type'=>'integer',
							  'required'=>false,
							'default'=>eZContentClass::VERSION_STATUS_DEFINED)),
			    'simple_category_options'=>array('content_class_attribute_id'=>
								 array ('type'=>'integer',
										  'required'=>true,
										  'default'=>0),
								  'category_array'=>
							 array('type'=>'array',
								 'required'=>false,
							     'default'=>null),
								 'version_id'=>
							 array('type'=>'integer',
								   'required'=>false,
							     'default'=>eZContentClass::VERSION_STATUS_DEFINED)),
			    'object_category_options'=>array('content_object_attribute_id'=>
								 array('type'=>'integer',
							     'required'=>true,
							     'default'=>0),
								 'version_id'=>
							 array('type'=>'integer',
								   'required'=>false,
							     'default'=>0)),
			    'object_category_values'=>array('content_object_attribute_id'=>
								array('type'=>'integer',
							    'required'=>true,
							    'default'=>0),
								'version_id'=>
							array('type'=>'integer',
								  'required'=>false,
							    'default'=>0)),
			    'category_option_values'=>array('content_class_attribute_id'=>
								array('type'=>'integer',
							   'required'=>true,
							   'default'=>0),
							     'option_id'=>
							array('type'=>'integer',
								 'required'=>true,
							   'default'=>0),
							     'category_id'=>
							array('type'=>'integer',
								 'required'=>false,
							   'default'=>0)),
			    'has_related_category_options'=>array('content_class_attribute_id'=>
									   array('type'=>'integer',
									 'required'=>true,
									 'default'=>0),
									   'version_id'=>
								   array('type'=>'integer',
									     'required'=>false,
								     'default'=>0)),
			    'category_option_array'=>array('content_class_attribute_id'=>
									   array('type'=>'integer',
									 'required'=>true,
									 'default'=>0),
									   'version_id'=>
								   array('type'=>'integer',
									     'required'=>false,
								     'default'=>0)),
			    'generate_category_string'=>array('option_category_array'=>
								  array('type'=>'array',
									  'required'=>true,
									'default'=>null)),
			    'is_empty_category'=>array('categories'=>
								  array('type'=>'array',
									  'required'=>true,
									'default'=>null)),
			    'category_option_simple_array'=>array('content_class_attribute_id'=>
								 array ('type'=>'integer',
										  'required'=>true,
										  'default'=>0),
								  'category_array'=>
							 array('type'=>'array',
								 'required'=>false,
							     'default'=>null),
								 'version_id'=>
							 array('type'=>'integer',
								   'required'=>false,
							     'default'=>eZContentClass::VERSION_STATUS_DEFINED)),
			    'thresholds'=>array('content_class_attribute_id'=>
									   array('type'=>'integer',
									 'required'=>true,
									 'default'=>0),
									   'version_id'=>
								   array('type'=>'integer',
									     'required'=>false,
								     'default'=>0)),
			    'inarray'=>array('needle'=>array('type'=>'string',
									 'required'=>true,
									 'default'=>""),
							   'haystack'=>array('type'=>'array',
									 'required'=>true,
									 'default'=>array()))
			);

	}

	function modify(&$tpl, &$operatorName, &$operatorParameters, &$rootNamespace,
			    &$currentNamespace, &$operatorValue, &$namedParameters){

		   switch($operatorName){

			    case 'option_filter': {

			    $operatorValue = $this->option_filter($namedParameters['content_object_attribute_id']);

			}

			    break;

			    case 'category_option_values': {

			   $operatorValue = $this->category_option_values($namedParameters['content_class_attribute_id'],
											$namedParameters['option_id'],
											$namedParameters['category_id']);

			}

			    break;

			    case 'generate_category_string': {

			    $operatorValue = $this->generate_category_string($namedParameters['option_category_array']);

			}

			    break;

			    case 'is_empty_category': {

			    $operatorValue = $this->is_empty_category($namedParameters['categories']);

			}

			    break;

			    case 'category_options': {

			    $operatorValue = $this->category_options($namedParameters['content_class_attribute_id'],
									   $namedParameters['category_array'],
										 $namedParameters['version_id']);

			}

			    break;

			    case 'simple_category_options': {

				$operatorValue = $this->simple_category_options(
					$namedParameters['content_class_attribute_id'],
					$namedParameters['category_array'],
					$namedParameters['version_id']);

			}

			    break;

			    case 'category_option_simple_array': {

				$operatorValue = $this->simple_category_options(
					$namedParameters['content_class_attribute_id'],
					$namedParameters['category_array'],
					$namedParameters['version_id']);

			}

			    break;

			    case 'object_category_options': {

				$operatorValue = $this->object_category_options(
					$namedParameters['content_object_attribute_id'],
					$namedParameters['version_id']);

			}

			    break;

			    case 'object_category_values': {

				$operatorValue = $this->object_category_values(
					$namedParameters['content_object_attribute_id'],
					$namedParameters['version_id']);

			}

			    break;

			    case 'has_related_category_options': {

				$operatorValue = $this->has_related_category_options(
					$namedParameters['content_class_attribute_id'],
					$namedParameters['version_id']);

			}

			    break;

			    case 'category_option_array': {

				$operatorValue = $this->category_option_array(
					$namedParameters['content_class_attribute_id'],
					$namedParameters['version_id']);

			}

			    break;

			    case 'thresholds': {

				$operatorValue = $this->thresholds(
					$namedParameters['content_class_attribute_id'],
					$namedParameters['version_id']);

			}

			    case 'inarray': {

				$operatorValue = $this->inarray(
					$namedParameters['needle'],
					$namedParameters['haystack']);

			}

			    break;


		 }

	}

	/*
	 * Param: contentObjectAttribute - content object attribute. It must
	 * be an ezcategoryselection type
	 * Returns: options of current content object attribute to be shown according to 
	 * selected options of current content object attribute's binded selection/ezcategoryselection attributes
	 * For example: if current content object attribute is 'city' attribute of a content object and it is binded to 
	 * 'country' attribute. If the selected option of 'country' attribute is 'China', then only the cities of 'China' 
	 * will be returned.
	 * Please note, if current content object attribute is 'cross class' or is not binded to any other attributes,
	 * then all options of current content object attribute will be returned.
	 * The structure of the return value is as the following:
	 * $attrValue = array( 'options' => $optionArray //options of current attribute,
	 *			   'categories'=> $categoryArray //categories of the category toolbar of current attribute, 
	 *			   'is_multiselect' => $classAttribute->attribute( 'data_int1' ), 
	 *			   'is_crossclass'=> $classAttribute->attribute('data_int2'), 
	 *			   'description'=> $classAttribute->attribute('data_text4'),
	 *			   'threshold'=> $classAttribute->attribute('data_int3') ); 
	 *
	 * $optionArray[$category_string_array['key']][] = $option;
	 *
	 * $option = array( 'id' => $optionNode['id'],
	 *			'name' => $optionNode['name'],
	 *			'categories'=>$optionCategoryArray,
	 *			'category_key'=>$category_string_array['key'],
	 *			'category_label'=>$category_string_array['value']); 
	 *
	*/
	function &option_filter(&$contentObjectAttribute){

		 //get class attribute of the content object attribute
		 $class_attribute = $contentObjectAttribute->contentClassAttribute();

		 //check if the attribute is 'cross class' or not
		 $cross_class = $class_attribute->attribute('data_int2');

		 //get class content of content object attribute
		 $class_content = $contentObjectAttribute->attribute('class_content');

		 //get all binded categories of content class attribute
		 $class_categories=$class_content['categories'];

		 //init object category array
		 $object_category_array=array();

		 //loop all binded categories of content object attribute 
		 //and add the category_id (the content class attribute id) as a key of
		 //object_category_array
		 foreach($class_categories as $class_category){

			 $object_category_array[$class_category['category_id']]=array();

		 }

		 //get content object id from content object attribute
		 $object_id = $contentObjectAttribute->attribute('contentobject_id');

		 //get class id from content class attribute
		 $class_id = $class_attribute->attribute('contentclass_id');

		 //fetch content object by object id
		 $object = eZContentObject::fetch($object_id);

		 //get all versions of object
		 $versions = $object->versions(true,array());

		 //loop all versions 
		 //and set object to the same version of 
		 //the content object attribute
		 foreach($versions as $version){

			 if($version->attribute('version')==$contentObjectAttribute->attribute('version')){

				 $object = $version;

				 break;
			 }

		 }

		 //get all content object attributes from object
		 $attributes = $object->contentObjectAttributes();

		 //loop all content object attributes
		 foreach($attributes as $attribute){

			 $class_attribute_id=$attribute->attribute('contentclassattribute_id');

			 //if the content class attribute id can be found in object_category_array
			 //it means the content class attribute is one of the binded categories of 
			 //the specified contentObjectAttribute.
			 //If this is the case, then the selected options of the content object attribute
			 //should be added to object_category_array
			     if(in_array($class_attribute_id,array_keys($object_category_array))){

			    $object_category_value=explode("-",$attribute->attribute('data_text'));

				    $object_category_array[$class_attribute_id]=$object_category_value;

			 }

		 }

		 //so far the object category values are ready for test
		 //class_options are all options of current content object attribute
		 $class_options=$class_content['options'];

		 //init show_option_array as an empty array
		 $show_option_array=array();

		 //if the object_category_array is empty 
		 //(current content object attribute has not been binded to any attributes) or 
		 //current content object attribute is corss class
		 //then all options of current content object attribute should be shown
		 //if(count($object_category_array)==0 || $cross_class){
		   if(count($object_category_array)==0){

			$show_option_array=$class_options;

		 }else{

			 //if current content object is not cross class and 
			 //the object_category_array is not empty
			 //(current content object attribute has been binded to at least one attribute)
			 //then 
			 //loop all class options of current content object attribute
		    foreach($class_options as $option){

			 //get the categories of each option
			 //option_categories are all categories binded to a specific 
			 //option of current content object attribute
			 $option_categories = $option['categories'];

			 //set flag 'show' to false by default
			 $show = false;

			 //loop all option categories
			 foreach($option_categories as $option_category){

				 //get category_id from option_category
				 //option_category is one of the categories binded to 
				 //a specific option of current content object attribute
				 $category_id = $option_category['category_id'];

				 if($cross_class){

				    $category_class_attribute = eZContentClassAttribute::fetch($category_id);

				    $category_class_id = $category_class_attribute->attribute('contentclass_id');

				  if($category_class_id!=$class_id){
						     
						 $show = true;

				     break;

				  }

				 }

				 //get category_value from option_category
				 //category_value are all values of the option_category
				 $category_value = $option_category['category_value'];

				 //get object_category_values from object_category_array
				 //object_category_values are the selected values of 
				 //the category of category_id
					 $object_category_values = $object_category_array[$category_id];

				 //set flag "show" to false by default
				 $show = false;

				 //loop all category_value
				 foreach($category_value as $value){

					 //if any value of the category_value option is matched in 
					 //selected value (object_category_values)
					 //then we should show this the corresponding option
					 if(in_array($value,$object_category_values)){

					    $show=true;

					    break;

					}

				}


				 //if not selected value is matched
				 //then ignore current option
				 if ($show==false){

				    break;

				 }

			}

			 //if show flag is true
			 //add current option to show list
			 if($show){

			   $show_option_array[]=$option; 

			 }

		   }

	    }

	    //return options to be shown
	    return $show_option_array;

	}


	/*
	 * Returns all option and category information of the specified content class attribute. You can also filter 
	 * the returned option and category information by specifying values for related categories.
	 * Param: content_class_attribute_id - current content class attribute id
	 * Param: category_array - array(category_id=>array(value...))
	 * for example: hash(100,array(1,2),101,array(3,4))
	 * Param: version - default 0
	 * Returns: if category_array is null or empty, it returns all options of current content class attribute
	 * if any values specified in category array, it returns all options of current content class attribute that 
	 * are binded to the specified category values in category_array. If current content class attribute is cross class
	 * , then all of its options and categories will be returned.
	 *
	 * The structure of the return value is as the following:
	 * $attrValue = array( 'options' => $optionArray //options of current attribute,
	 *			   'categories'=> $categoryArray //categories of the category toolbar of current attribute, 
	 *			   'is_multiselect' => $classAttribute->attribute( 'data_int1' ), 
	 *			   'is_crossclass'=> $classAttribute->attribute('data_int2'), 
	 *			   'description'=> $classAttribute->attribute('data_text4'),
	 *			   'threshold'=> $classAttribute->attribute('data_int3') ); 
	 *
	 * $optionArray[$category_string_array['key']][] = $option;
	 *
	 * $option = array( 'id' => $optionNode['id'],
	 *			'name' => $optionNode['name'],
	 *			'categories'=>$optionCategoryArray,
	 *			'category_key'=>$category_string_array['key'],
	 *			'category_label'=>$category_string_array['value']); 
	 *
	 * $optionCategoryArray[]=array('category_id'=>$optionCategory['category_id'],
	 *					'category_value'=>$optionCategory['category_value']);
	 *
	*/
	function &category_options($content_class_attribute_id,
					 $category_array=null,
					 $version_id=eZContentClass::VERSION_STATUS_DEFINED){

		   //fetch class attribute by current class attribute id
		 $classAttribute_tmp = eZContentClassAttribute::fetch($content_class_attribute_id,true,$version_id);
		   $classAttribute=& $classAttribute_tmp;

		 $dom_tmp = $classAttribute->attribute('content');
		 $dom =& $dom_tmp;

		 //init option array as an empty array
		   $optionArray = array();

		 //init category array as an empty array
		   $categoryArray = array();

		 //if dom is an object
		   if ( $dom ){

			  //restore current options from xml
			  $options =& $dom['options'];

		    //loop all options 
			  foreach ( $options as $optionNode ){

				//get option categories from option
			    $optionCategories = $optionNode['categories'];

			//init option category array as an empty array
			  $optionCategoryArray = array();

			//init option category record array as an empty array
			$option_category_record_array=array();

			//loop all option categories of current option
			  foreach($optionCategories as $optionCategory){

				//append category values into option category array
				    $optionCategoryArray[]=array('category_id'=>
						$optionCategory['category_id'],
						'category_value'=>$optionCategory['category_value']);

				//append category values into option category record array
				$option_category_record_array[$optionCategory['category_id']]= 
					$optionCategory['category_value'];

			    }

			//generate category string array based on option category array
			//category string array is an array like 'key'=>category_id_string
			//'value'=>category_value_string
	 		  $category_string_array = $this->generate_category_string($optionCategoryArray);


			//set matched flag as true by default
			$matched = true;

			//if category array has any elements
			//note, the category array is additional filter
			//category_array is something like this:
			//array(category_array_id=>category_array_value)
			if($category_array!=null){

			   //set matched flag to false 
				   $matched = false;

			   //loop all elements in category_array
			   foreach($category_array as $category_array_id=>$category_array_value){

				   //if current category id exists in option category record array
				   if(isset($option_category_record_array[$category_array_id])){

					   //if category_array value is empty, means no limitation has been
					   //specified, thus no options shall be removed
					   //we should then break current loop and continue loop with next element
					   if(count($category_array_value)==0){

						   $matched = true;

						   break;

					   }

						 //set matched flag to false 
					   //we should set matched to false each time
					   //so that if any category failed to match, the entire match will failed.
							 $matched = false;

					   //if any elements found in category_array_value
					   //means you have specified some limitation 
					   //then, we will loop every value in the category_array_value
					   foreach($category_array_value as $filter_value){

						   //if any value in category array value has 
						   //been matched in option_category_record_array
						   //then, we found a match 
						   //we should set matched to true and break current loop
						   if(in_array($filter_value,
								 $option_category_record_array[$category_array_id])){

							 $matched = true;

							 break;

						   }

					   }

					   //if current match failed, 
					   //we should set $matched to false and break the loop
					   //thus, we know that at least one of the category value is not matched
					   if($matched == false){

						   break;

					   }


				   }


			     }


			}//end of if ($category_array!=null)

			  $option = array( 'id' => $optionNode['id'],
					   'name' => $optionNode['name'],
				 'categories'=>$optionCategoryArray,
				   'category_key'=>$category_string_array['key'],
				   'category_label'=>$category_string_array['value']);

				if($matched){

				   $optionArray[$category_string_array['key']][] = $option;

			}


		 }//end of foreach ( $options as $optionNode )


		 //restore current categories from xml
		 //$root =& $dom->get_root();
		   //$categories =& $root->elementChildrenByName( 'categories' );
		   $categories =& $dom['categories'];

		   //$categoryArray = array();
		   foreach ( $categories as $categoryNode ){

				 $categoryArray[] = array( 'id' => $categoryNode['id'],
							 'category_id'=>$categoryNode['category_id'],
						 'category_value' => $categoryNode['category_value']);

		   }


	  }//end of if ( $dom )

	//store current options, current categories and is_multiselect in attrValue
	  $attrValue = array( 'options' => $optionArray,
				  'categories'=> $categoryArray,
			    'is_multiselect' => $classAttribute->attribute( 'data_int1' ),
			    'is_crossclass'=> $classAttribute->attribute('data_int2'),
				'description'=> $classAttribute->attribute('data_text4'),
				'threshold'=> $classAttribute->attribute('data_int3') );

	  return $attrValue;

	}

	/*
	 * Param: categories - categories is the category array of an option
	 * Returns: array('key'=>$category_id_string,'value'=>$category_value_string)
	 * For example: category1 [ cccc | dddd ] <br> category2 [ gggg | hhhh ]
	*/
	function &generate_category_string(&$categories){

		  return eZCategorySelectionType::generate_category_string($categories);

	}

	/*
	 * Param: category array
	 * Return: if any of the category value is not "", returns false
	 * otherwise, returns true
	*/
	function is_empty_category(&$categories){

		 $flag = true;

		 foreach($categories as $category){

			     foreach($category as $value){

				 if($value!=""){

					 $flag = false;

					 break;

				 }

			 } 

			 if(!$flag){

				 break;

			 }

		 }

		 return $flag;

	}
	

	/*
	 * Deprecated !! - does not work with duplicate option names
	 * please use category_option_simple_array which use 'option id' as key
	 * Param: content_class_attribute_id - current content class attribute id
	 * Param: category_array - same as category_array in function category_options
	 * Param: version - default 0 
	 * Returns: same as the return value of category_options but 
	 * it is in the simple form. array('option name'=>'option id').
	 * It's useful when you want to display the options in a <select>
	 */
	function &simple_category_options($content_class_attribute_id,
						  $category_array,
						  $version_id=eZContentClass::VERSION_STATUS_DEFINED){

		 $options = $this->category_options($content_class_attribute_id,$category_array,$version_id);

		 $options = $options['options'];

		 $result = array();

		 foreach($options as $option_array){

			 foreach($option_array as $option){

				 $result[$option['name']]=$option['id'];

			 }

		 }

		 ksort($result);

		   return $result;

	}


	/*
	 * It first retrieves all options and categories of current content object attribute id by 
	 * category_options() function. Then, the options and categories of the un-selected options will be 
	 * removed. Finally, only the option and category information of the selected options of current content 
	 * object attribute will be returned.
	 * Param: content_object_attribute_id - current content object attribute id
	 * Param: version - default 0 
	 * Returns: the option and category information of the selected options of current content object attribute
	 * The structure of the returned value is same as the returned value of function category_options()
	*/
	function &object_category_options($content_object_attribute_id,
						  $version_id=0){

		   //fetch object attribute by current content object attribute id
		   $object_attribute = eZContentObjectAttribute::fetch($content_object_attribute_id,$version_id);

		 //fetch current class attribute from content object attribute
		 $class_attribute = $object_attribute->contentclassAttribute();

		 //get class attribute name
		 $class_attribute_name = $class_attribute->attribute('name');

		 //get class attribute id
		 $class_attribute_id = $class_attribute->attribute('id');

		 //get all class options by function category_options()
		 $class_options = $this->category_options($class_attribute_id);

		 //get object content from content object attribute
		 //object_content is an array contains ids of the selected options
		 $object_content = $object_attribute->content();

		 //get class option array from class options
		 $options = $class_options['options'];

		 //loop all elements in class option array
		 foreach($options as $key=>$option){

			 //loop all class option entries 
			 foreach($option as $option_key=>$option_entry){

				 //if the class option id is not found in object content
				 //means the class option is not selected for current content object attribute
				 //we will unset it from the option array 
				 if(!in_array($option_entry['id'],$object_content)){
				   unset($option[$option_key]);
				 }

			 }

			 //if all entries have been unset
			 //we will unset the entire option entry
			 if(count($option)==0){

			  unset($options[$key]);

			 }

		 }


		 return $options;

	}

	/*
	 * It first fetch option and category information of the selected options of current content object attribute.
	 * Then, for each option, it fetches the category id and category option id and use category option id to fetch 
	 * the category option name. Finally, it combines all information to an array.
	 * Param: content_object_attribute_id - current content object attribute id
	 * Param: version - default 0
	 * Returns: the category value information of the selected options of current object attribute.
	 * The structure of the category value information is as the following
	 * value[category_id]['name']=the attribute name of the category
	 * value[category_id]['values'][option name]=array{category_name1, category_name2, ....}
	*/
	function &object_category_values($content_object_attribute_id,
						 $version_id=0){

		   //get all option and category information of the selected options of
		 //current content object attribute
		   $options = $this->object_category_options($content_object_attribute_id,
							   $version_id);

		 //init values as empty array
		 $values = array();

		 //loop all option in options 
		 foreach($options as $key=>$option){

			 //loop all option entries in option
			 foreach($option as $option_key=>$option_entry){

				 //get categories from current option entry
				   $categories = $option_entry['categories'];

				 //loop all category in current categories
				 foreach($categories as $category){

					 //get class attribute by category['category_id']
					 $class_attribute = 
						 eZContentClassAttribute::fetch($category['category_id']);

					 //get category name - the name of the category attribute
					 //for example, name of category 1 in 'country' attribute might 
					 //be China
					   $category_name = $class_attribute->attribute('name');

					 //set category_id
					 $category_id = $category['category_id'];

					   $values[$category_id]['name'] = $category_name;

						   $current_values = $category['category_value'];

					 $option_entry_name = $option_entry['name'];

					 $simple_options = $this->category_option_simple_array($category_id);

					   foreach($current_values as $value){

						 $values[$category_id]['values'][$option_entry_name][] = 
						 $simple_options[$value];

					   }

				 }

			 }

		 }

		 return $values;

	}

	/*
	 * Check if the specified class attribute affects any other attributes in the same content class or not
	 * Param: content_class_attribute_id
	 * Param: version_id - default 0
	 * Returns: true - if current class attribute affects other attributes; false - if it does not.
	*/
	function &has_related_category_options($content_class_attribute_id,
							 $version_id=eZContentClass::VERSION_STATUS_DEFINED){

		   $class_attribute = eZContentClassAttribute::fetch($content_class_attribute_id,true,$version_id);

		 $class_attribute_id = $class_attribute->attribute('id');

		 $class_id = $class_attribute->attribute('contentclass_id');

		   $class = eZContentClass::fetch($class_id);

		 $class_attributes = $class->fetchAttributes();

		 $matched = false;

		 foreach($class_attributes as $attribute){

			 $data_type_string = $attribute->attribute('data_type_string');

			 $id = $attribute->attribute('id');

			 if($data_type_string=='ezcategoryselection' &&
			  $id!=$class_attribute_id){

					 $category_options = $this->category_options($id);

				 $options = $category_options['options'];

				 foreach($options as $key=>$option){

					 foreach($option as $option_categories){

						 $categories = $option_categories['categories'];

						 foreach($categories as $category){

							 $category_id = $category['category_id'];

							 if($category_id==$class_attribute_id){

									    $matched = true;

							  break;

							 }

						 }

						 if($matched){

							 break;
						 }

					 }

					 if($matched){

						 break;

					 }

				 }

			 }

			     if($matched){

				 break;

			 }

		 }

		 return $matched;

	}

	/*
	 * Param: content_class_attribute_id - current content class attribute id
	 * Param: category_array - same as category_array in function category_options
	 * Param: version - default 0 
	 * Returns: same as the return value of category_options but 
	 * it is in the simple form. array('option id'=>'option name').
	 * It's useful when you want to display the options in a <select>
	 * The structure of the return value is as the following:
	 * result[option_id]=option_name;
	 */
	function &category_option_simple_array($content_class_attribute_id,
							 $category_array,
							 $version_id=eZContentClass::VERSION_STATUS_DEFINED){

		 $options = $this->category_options($content_class_attribute_id,$category_array,$version_id);

		 $options = $options['options'];

		 $result = array();

		 foreach($options as $option_array){

			 foreach($option_array as $option){

				 $result[$option['id']]=$option['name'];

			 }

		 }

		 ksort($result);

		   return $result;

	}

	/*
	 * ezcategoryselection has two attributes: 'threshold' and 'description'. 
	 * The 'threshold' is supposed to store a threshold value (integer type) for specific purpose.
	 * One possible usage of these attributes might be: specifying a threshold value and a description text for each 
	 * ezcategoryselection attribute. Then, bind these attributes to another ezcategoryselection attribute. In this case, 
	 * we actually defined a logic as the following:
	 * different threshold value of the binded ezcategoryselection attribute is connected to a description statement.
	 * This is useful for defining the result of a questionnaire.
	 * Param: content_class_attribute_id - content class attribute id
	 * Param: version_id - default 0
	 * Returns: the threshold value and its description statement of all ezcategoryselection attributes that are binded
	 * to current class attribute. 
	 * The structure of the returned value is as the following:
	 * thresholds[threshold value] = description statement;
	 * thresholds[0] = description of current class attribute;
	*/
	function &thresholds($content_class_attribute_id,
				  $version_id=eZContentClass::VERSION_STATUS_DEFINED){

		   $class_attribute = eZContentClassAttribute::fetch($content_class_attribute_id,true,$version_id);

		 $content = $class_attribute->attribute('content');

		 $class_attribute_id = $class_attribute->attribute('id');

		 $class_id = $class_attribute->attribute('contentclass_id');

		   $class = eZContentClass::fetch($class_id);

		 $class_attributes = $class->fetchAttributes();

		 $thresholds = array();

		 $thresholds[0]=$content['description'];

		 $matched = false;

		 foreach($class_attributes as $attribute){

			 $data_type_string = $attribute->attribute('data_type_string');

			 $id = $attribute->attribute('id');

			 if($data_type_string=='ezcategoryselection' &&
			  $id!=$class_attribute_id){

			    $content = $attribute->attribute('content');

			  $categories = $content['categories'];

			  foreach ($categories as $category){

				   $category_id = $category['category_id'];

				   if($category_id==$class_attribute_id){

					$thresholds[$content['threshold']] = $content['description'];

				   }

			  }

			 }

		 }

		 ksort($thresholds);

		 return $thresholds;

	}

	/*
	 * Returns all option and category information of the specified class attribute. However, the returned value has 
	 * different structure with function category_options(). 
	 * This function is used by the datatype templates to construct the javascript array
	 * Param: content_class_attribute_id - current content class attribute id
	 * Param: version_id - default 0
	 * Returns: all option and category information of the specified class attribute. 
	 * The structure of the returned value is as the following:
	 * result[option_id][category_id]={category_value1, category_value2, ....};
	 * option_id - the id of the option
	 * category_id - the content class attribute of the category 
	 * category_value - the 'name' of the category option
	*/
	function &category_option_array($content_class_attribute_id,
						$version_id=eZContentClass::VERSION_STATUS_DEFINED){

		   $result = array();
						    
		   $category_options = $this->category_options($content_class_attribute_id);

		 $options = $category_options['options'];

		 foreach($options as $option){

			 foreach($option as $entry){

				 $option_id = $entry['id'];

				 $option_name = $entry['name'];

				 $result[$option_id]=array();

				 $categories = $entry['categories'];

				 $category_array = array();

				 foreach($categories as $category){

					 $category_id = $category['category_id'];

					 $category_values = $category['category_value'];

					 $category_array[$category_id]=$category_values;

				 }

				 $result[$option_id]['categories']=$category_array;

				 $result[$option_id]['name']=$option_name;

			 }
		 
		 }

		 return $result;

	}


	/*
	 * This function is used to fetch the category values of 
	 * the specific option and category of current class attribute. 
	 * Param: content_class_attribute_id - current content class attribute id
	 * Param: option_id - option id of current option
	 * Param: category_id - default 0
	 * Returns: option value and the category values
	 * The structure of the returned value is as the following:
	 * values[category_id]['values']={category_value1,category_value2,....}
	 * values[category_id]['name']=category attribute name
	 *
	*/
	function &category_option_values($content_class_attribute_id,$option_id,$category_id=0){

		 $category_options = $this->category_options($content_class_attribute_id);

		 $options = $category_options['options'];

		 $values = array();

		 foreach($options as $option_array){

		foreach($option_array as $option){

		  if($option['id']==$option_id){

		     $categories = $option['categories'];

		     foreach($categories as $category){

				     if($category_id!=0){

					  if($category['category_id']==$category_id){

				   //get class attribute by category['category_id']
				   $class_attribute = eZContentClassAttribute::fetch($category['category_id']);

				   $class_attribute_content = $class_attribute->attribute('content');

				   $class_attribute_options = $class_attribute_content['options'];

					     $values[$category['category_id']]['values']=$category['category_value'];

				   $class_attribute_array = array();

				   foreach($class_attribute_options as $class_attribute_option){

					   $class_attribute_array[$class_attribute_option['id']]=
						   $class_attribute_option['name'];

				   }

				   foreach($values[$category['category_id']]['values'] as $key=>$option_id){

					   $values[$category['category_id']]['values'][$key]=
						   $class_attribute_array[$option_id];

				   }

				     $category_name = $class_attribute->attribute('name');

					     $values[$category['category_id']]['name']=$category_name;

					     break;

					  }

				     }else{

				   //get class attribute by category['category_id']
				   $class_attribute = eZContentClassAttribute::fetch($category['category_id']);

				   $class_attribute_content = $class_attribute->attribute('content');

				   $class_attribute_options = $class_attribute_content['options'];

					     $values[$category['category_id']]['values']=$category['category_value'];

				   $class_attribute_array = array();

				   foreach($class_attribute_options as $class_attribute_option){

					   $class_attribute_array[$class_attribute_option['id']]=
						   $class_attribute_option['name'];

				   }

				   foreach($values[$category['category_id']]['values'] as $key=>$option_id){

					   $values[$category['category_id']]['values'][$key]=
						   $class_attribute_array[$option_id];

				   }

				     $category_name = $class_attribute->attribute('name');

					     $values[$category['category_id']]['name']=$category_name;

				    }


			  }

		    break;

		 }

		 }

	    }

	    return $values;

	}

	function inarray($needle, $haystack) {

		if (is_array($haystack)) {

			return in_array($needle, $haystack, true);

		}

		return false;

	}

}

?>
