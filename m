Return-Path: <linux-kernel+bounces-372177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DB09A4551
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2AC1C23CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D90720401E;
	Fri, 18 Oct 2024 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pwta1cxe"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F712038B4;
	Fri, 18 Oct 2024 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274186; cv=none; b=onpwDmxIXYEQZR4qS7horXQSLcNRWZiJmDkjCS+fIiGXUzhVfrDl0Qo+RQcSmvLo8uQL4HxANZ66wkRvNlUfVBCBkFOI+AP0GdK7H80Wsk+e6S8nxhdofOPTlQ8E89zjnkc7pu9jI9Wnp1U/CJfA3TJASwykp+baVeNQK+Fqlj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274186; c=relaxed/simple;
	bh=12ItbSqaZwxlMTt2WSyenPaLtURDb8Hoa9wUR++z1UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gh8vPpNplR1+0stLDuDjcEe5MWeAC5U+e7PuU0xYl3riOUIYHrOZw02pcI+6LD4eTdSYK5VpXKnoTqDVKi4KVPPHaN+y3oGxuQK5yRUA5FptcnhfUQYa8oSJMBdzgTPGbSXuE5I0coDMo8mRiY/4xtmwQibnmFBOA2WdPXTu16Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pwta1cxe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D1tyVh3hRf2lr7BlmGAOL8606KTw+opaSL4arqPA3mQ=; b=Pwta1cxe44D90gWQINck2lbgov
	nMNHmbyxfHhPioCo79bw708oP1chk9ugXecLppbZXgiGE5YznuNgZMnviQhVx5DbJ73yqT+Vvb45+
	Iqpu1mTyetzHvORWmDdfLriMyYmHjtUkT/f9s4vAV1DUoVWmobamM5Sebiu/g7pr9KXpflem90B5L
	UAfSuB9Vm5Z6T9ebBx01zDKLaq57fnY82WJhrC2XE5TQwZRNf4N7G5g8PR1dNcyZZq9TiDyET0Q3R
	kL3ycMGkCydtsOFNAiLaq0kDljNf5uK2rAkUSKSrIK44yv+XiESH/avXo2Ikigvm1HgzndCLYGikz
	Jqo5gxxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1rD3-0000000DRTZ-2IYa;
	Fri, 18 Oct 2024 17:56:21 +0000
Date: Fri, 18 Oct 2024 18:56:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Nir Lichtman <nir@lichtman.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	dianders@chromium.org, corbet@lwn.net, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: English fixes in kgdb/kdb article
Message-ID: <ZxKhRTereZT1ZZf-@casper.infradead.org>
References: <20241018163136.GA795979@lichtman.org>
 <ZxKaZR_M-mOjSmBp@casper.infradead.org>
 <20241018174953.GA796860@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018174953.GA796860@lichtman.org>

On Fri, Oct 18, 2024 at 05:49:53PM +0000, Nir Lichtman wrote:
> > > -   Now disconnect your terminal program and connect gdb in its place
> > > -
> > 
> > Is there a reason you deleted this?  It seems important.
> > 
> 
> Yes, this sentence is duplicated twice (with slightly different wording), here and a line below.

Right you are.  I should have looked more closely.

