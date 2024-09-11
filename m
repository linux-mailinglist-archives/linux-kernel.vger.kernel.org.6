Return-Path: <linux-kernel+bounces-325367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEEB9758A7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D3C1C22F15
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678B01AED32;
	Wed, 11 Sep 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOXF8KE/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4589383B1;
	Wed, 11 Sep 2024 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726072992; cv=none; b=E6bHSmGi/Ovo1pTEkKKjD/T/EshZcdyx/f9UCXMe+Oq1t6mKE/wCHQ6gRqk1Yg6MeeB0hQ7NoMVfUDwQZ6V6GUeisaDUs+TMkyOC533sCLenlgtgv5KToBAVa0assIA4SegRhDd3TxGSbWUxlqKNUVB/XwWhdGim49Tn4oD5nh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726072992; c=relaxed/simple;
	bh=yTKnHqS1TKRvdn3M9rhyopTwDU3fOvUVzJwOO+EdAtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuwbcpvqCdROaPcZM7V8T25bH0MBMGNopElcdQb64sJ8kiisdY8QAS4hW4/ua53ZKHejZCsnZxwLHTvSzmsQQqFDZzN0vwcLkYORdk/4DFeaVmZb3iEgQGd13owjj8DzK20rN0XUSTDwuk+zdfZnVTyk2C9KLb7r81xNCKv/BEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOXF8KE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40056C4CEC0;
	Wed, 11 Sep 2024 16:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726072992;
	bh=yTKnHqS1TKRvdn3M9rhyopTwDU3fOvUVzJwOO+EdAtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MOXF8KE/pKP7RXSarojs2m5au1NmcyVwVZ10aZAdoDnuhx73kL+agBCqsbt70vWqy
	 FxnILXCWb6lFjORI0Tajl5TxMjjJlZ+JccS/7ZMW537o0oaxSkUq03GPde2j7aSrjX
	 O299goJCyjLDVhEIDy7DkhQc3H/lHW5xecAxcFm8oFgGutPIk16SLMpGpnV7/Aljhu
	 x8HZc8Dii8YDIkHj9WPiEzC0+ighozBN9VvCkg3P3Z33BpKfgaG2uMHnBwqK7Ao7JT
	 VfWa+07yNJTYH5yYGESB7CA0RPl467enwJ0ZjPlI6hGMzcmtF3cHE6dTZdQ9M7o84J
	 ZriUEyZ5CwcVQ==
Date: Wed, 11 Sep 2024 11:43:11 -0500
From: Rob Herring <robh@kernel.org>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mikisabate@gmail.com>
Cc: saravanak@google.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/of: Improve documentation on match string
Message-ID: <20240911164311.GA775781-robh@kernel.org>
References: <20240910142422.341672-1-mikisabate@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240910142422.341672-1-mikisabate@gmail.com>

On Tue, Sep 10, 2024 at 04:24:22PM +0200, Miquel Sabaté Solà wrote:
> The description of the function now explicitly states that it's
> an *exact* match for the given string (i.e. not a submatch). It also
> better states all the possible return values.
> 
> Moreover, this commit also makes sure that -ENODATA is returned if
> prop->length is zero, just like it's done in other functions such as
> 'of_property_read_string'.

'also' in a commit message is a sign this should be 2 commits. However, 
more below.

> 
> Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>
> ---
>  drivers/of/property.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 164d77cb9445..1ff51d93178f 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -452,12 +452,17 @@ EXPORT_SYMBOL_GPL(of_property_read_string);
> 
>  /**
>   * of_property_match_string() - Find string in a list and return index
> - * @np: pointer to node containing string list property
> + * @np: pointer to the node containing the string list property
>   * @propname: string list property name
> - * @string: pointer to string to search for in string list
> + * @string: pointer to the string to search for in the string list
>   *
> - * This function searches a string list property and returns the index
> - * of a specific string value.
> + * Search for an exact match of string in a device node property which is a
> + * list of strings.
> + *
> + * Return: the index of the first occurrence of the string on success, -EINVAL
> + * if the property does not exist, -ENODATA if the property does not have a
> + * value, and -EILSEQ if the string is not null-terminated within the length of
> + * the property data.
>   */
>  int of_property_match_string(const struct device_node *np, const char *propname,
>  			     const char *string)
> @@ -469,7 +474,7 @@ int of_property_match_string(const struct device_node *np, const char *propname,
> 
>  	if (!prop)
>  		return -EINVAL;
> -	if (!prop->value)
> +	if (!prop->value || !prop->length)

This is redundant. If length is 0, then 'end' will be equal to p and 
we'll return -ENODATA.

>  		return -ENODATA;
> 
>  	p = prop->value;
> --
> 2.46.0
> 

