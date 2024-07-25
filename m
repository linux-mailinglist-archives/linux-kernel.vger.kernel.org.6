Return-Path: <linux-kernel+bounces-261773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFBA93BBF3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16E31C2031D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 05:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA0A1C6B7;
	Thu, 25 Jul 2024 05:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fkDvBVWQ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D011B1BF31;
	Thu, 25 Jul 2024 05:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721883977; cv=none; b=uIgkhfCYMIypaV5YxYWWyrN3SFt85V2Fl6RoaiMkrlOPDzLStasJXelWkneLDrbL6Uy/3ze90T4DcQ+LWQhGSMcB9XprlvdcC1scvUIY5yZA7qF38NGt+DHmQsbfHIsIw+i7msSaYTax2mHYcKK9T1uCv4UYHXIIsBZC34w12YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721883977; c=relaxed/simple;
	bh=PlITPw0r+Wd1Bf6wMLsgTRpboomujwKay/y8VQCh4gY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvl3vxo0O+1+hJlFL3pF0tNeAbMrgVEzQwYxMffl6jY9rHKOxT55YU9Z1TmlVdxoE5UJUP432PzCPxbKbp2ppFAmOyuLJuczEvqZLU8a6hE7UebU2mDzEHGWB4gq84vpJxIrNE0osqm7go7DRrxCpkiSUaVFgv/oPIdXxalWA7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fkDvBVWQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ljWC/5Z2caE7g4bTRZgshdWjFb5m9133Aw6+mYHyWdY=; b=fkDvBVWQOmdff2PIMNhXDhbp5j
	Vjuf0wQ+WsS1hEM9EQdBGtianAqmtv21Tnt0AW7BAfX0iq0HPBcbIs2H0OtyPJ9gJ1lvW9fycVZfu
	cQQ7CBPDID6UksaDzzT23rpePiZ0FDky93RZIyaYtePYZHvjMLpdw9M2zAZtWf1CyRT+fIsteR2TT
	0Dl8wrQa/MHNJcET3iOiOPh1a6yro8tSZ5eQe9g4zhvf40i5K6iARQ23gkn+nrgJx2ELRzCP/tSeG
	EOlhTcMLA2q+QbmbfD2iPTMNZgUYJwxrBTXEVWDlVcVuWX8zoIJp8ZCXpfCHrhEyAzYSPTd6V65PL
	NJsq5FbQ==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWqg1-0000000HQ9Q-2dlJ;
	Thu, 25 Jul 2024 05:06:05 +0000
Message-ID: <b7ec9dba-5ba7-40d1-b1a0-e85f3149f445@infradead.org>
Date: Wed, 24 Jul 2024 22:06:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 9p goo.gl link
To: "Dr. David Alan Gilbert" <linux@treblig.org>, ericvh@kernel.org,
 lucho@ionkov.net
Cc: v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZqE9zUXO3agBjno7@gallifrey>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZqE9zUXO3agBjno7@gallifrey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/24/24 10:45 AM, Dr. David Alan Gilbert wrote:
> Hi,
>   I noticed there was a goo.gl link in Documentation/filesystems/9p.rst
> 
>     * VirtFS: A Virtualization Aware File System pass-through
>       http://goo.gl/3WPDg
> 
> Given goo.gl is going away, I was going to expand the link, but
> the link looks fairly ill; it goes to a sciweavers.org site
> that has an abstract, but it doesn't seem to download the full document.
> 
> I can see links to the document around, but I'm not sure if there's
> a 'right' address.

Yeah, it (or a variant of it) is available in quite a few places.

I prefer this one:
https://kernel.org/doc/ols/2010/ols2010-pages-109-120.pdf


-- 
~Randy

