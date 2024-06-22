Return-Path: <linux-kernel+bounces-225877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D50291369D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 00:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAAE1C21458
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 22:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339AB770F1;
	Sat, 22 Jun 2024 22:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NlCcKNaT"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3BC168CC;
	Sat, 22 Jun 2024 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719095256; cv=none; b=mDPWlg97eSQQOJMrPdZ3F/XW3Ql6XUt9IPV/hybIDi4yIn7vLc7WadWypcLMAkxFadsB8GSMvfBy602KWXirtKPqE8eGi4n9HE/JRuscIcqVaalHW13ObUakJH0rt6J6FBgwh0uhFoeXw0/c80g1yu0K+PpNidvG2v2n+dxhMOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719095256; c=relaxed/simple;
	bh=rzPGLUFYIUdHGrDKSup+7bW7GBCp6kz5CEsbQ/6VCqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPVJa5WSoiX1S+A1bfYyrcAutV/WCNZu6305jvjy1k9IJSpayT8wYBu5UrlGcyh6ROsfL/iNmmFs7XfXmW8u5fKUQWJlV45iXCrNG3BHfERp3mxUm5nCPb5TWsRn1Yq8lU8o/GcB0jLEBSiFSHoZBtFIXd83mj6x/yZlrAGWFHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NlCcKNaT; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7EF11BF204;
	Sat, 22 Jun 2024 22:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719095246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=50DF7I6vU6d2IC+95xHyR+CKeEExnUgWF7or+j27i+U=;
	b=NlCcKNaTnU1o0nZkB/r7PiQRsSjMo7bmw9qoJlGBBK3VLTBxiwH84OieBNGV2hud/OHGnH
	/k/5yWrDXfL0Ww+zsf1KfneUwpTY85Wbm5sqB0eKXXcxjij8eHadBlCFbxqRt0Xzl30sxh
	na9K/hyklywesPFPTCgk1iEVSYzgMFu2etxTRF8DfjM0qyaeXy65UBJhfbOE5W/452U0wJ
	ou4o8fBLy9GzAfhdUlv++3A1rYgGsU/5c7LgmSyjAPnB5kW/BXfp64f5xhbKpEiRI8UqEv
	J6hynucOlRw9G0hca58vzP2+huon5lwJk0NIHtde4gOsJRM5veJFH1WF/mgNtg==
Date: Sun, 23 Jun 2024 00:27:25 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Aniket ." <aniketmaurya@google.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] i3c: dw: Add optional apb clock
Message-ID: <202406222227157424f82d@mail.local>
References: <20240611171600.1105124-1-aniketmaurya@google.com>
 <20240611171600.1105124-3-aniketmaurya@google.com>
 <202406182005584f0deea8@mail.local>
 <20240618200932858a6e40@mail.local>
 <CAMmmMt21TAH3Vp8axtY9PoM0K6gzQqtMiHTaNGXKPW3J2DJF-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMmmMt21TAH3Vp8axtY9PoM0K6gzQqtMiHTaNGXKPW3J2DJF-Q@mail.gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 20/06/2024 11:42:25+0530, Aniket . wrote:
> Hey,
> > > >     ret = clk_prepare_enable(master->core_clk);
> >
> > It could be worth having a look at devm_clk_get_optional_enabled
> Do we want to use *_enabled clock apis for both core_clk and pclk?

Yes

> 
> Thanks,
> Aniket
> 
> -- 
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

