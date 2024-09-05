Return-Path: <linux-kernel+bounces-317309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8E196DC2A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FB0289C3E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5824117993;
	Thu,  5 Sep 2024 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m+eodu65"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ED817BA0;
	Thu,  5 Sep 2024 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547337; cv=none; b=lmqFvdN1MWkFLnWMSB/SRFsteuTuAgfAQfMODvtc4Xp5UMcA26Fzbfv+oME7j+loy3IaoFthr7dI/CgScMtRoI0yC+4ZzT7aI4Ah6VtmkI9Is0dUJsbBTB3bqA9UDazPG6wiAngOmN6jlibNbI5r3XFJi4KcVD/rGXlHLr3pWlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547337; c=relaxed/simple;
	bh=Uzs2oPtObAD0pPyw4Ae0NGJuk+fIOglpcpgIvakc1Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiSIYs5fWusC/DhJSBv2EE9YyOsqRnFrn05mkW1CAcudkJ9Oc9I46xExlfXcooxo6grY85Ae+UES9W3Yg53Vwe+MRJKmBo5ROu930GfDZ3pEbh/lcyQU6eDA8PPLztxk9ryx56qE9CzTjz48L3HvQ5tF4y9K4SM2hxdovSx+u0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m+eodu65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E05C4CEC3;
	Thu,  5 Sep 2024 14:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725547337;
	bh=Uzs2oPtObAD0pPyw4Ae0NGJuk+fIOglpcpgIvakc1Jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+eodu65CH3C/U7q07sHcN2wCsMpcde6OmdXvy8GurpI+77Dc7JX3ggd5K5beab1A
	 9bYQbHj4G49RXsqSENspaui/auGzcvgmKGgj2WRS5SRhw8433p3QC5JWV5iIPTb2N4
	 v1u/rhbFS2JI1FU/TP7FXXlOtrrYO6vQ+yRKISVA=
Date: Thu, 5 Sep 2024 10:42:13 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] docs: submitting-patches: Advertise b4
Message-ID: <20240905-happy-friendly-caribou-48e97f@lemur>
References: <20240905-documentation-b4-advert-v2-1-24d686ba4117@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240905-documentation-b4-advert-v2-1-24d686ba4117@kernel.org>

On Thu, Sep 05, 2024 at 01:33:33PM GMT, Mark Brown wrote:
> b4 is now widely used and is quite helpful for a lot of the things that
> submitting-patches covers, let's advertise it to submitters to try to make
> their lives easier and reduce the number of procedural issues maintainers
> see.

I consider the prep/send parts a bit experimental still, as they do
periodically explode. :) However, we will find and fix more corner cases as
the user base grow(l)s, so I'm all for this inclusion.

Acked-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

-K

