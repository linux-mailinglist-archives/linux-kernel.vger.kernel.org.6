Return-Path: <linux-kernel+bounces-348348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F4498E67A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 00:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98921F2213D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0827019CC0D;
	Wed,  2 Oct 2024 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a/NNsuFQ"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D840219C56B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 22:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909744; cv=none; b=uXmTboLiVqCyazr6tIy2EOyL6vsIuYIFCcZOXNsaa4nlrRjBPjAHbOKhjj6P5E/chVNi59qyfWLC9ibrEqZ4iHiBpIIZDI5o/dBLacWCd5HLeFbdsM7XK8PXd1AEnohZL7Z9HRAHB56pIXjXo5tiQH6wbp5EYuwqzGynSXr5RP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909744; c=relaxed/simple;
	bh=OT8vUKCWjczcFOuZn4PPrmZ9GWvhs9YmkuaPsre8b0w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nKCaC9JV05OQn78rxDS/GfrDin+WL3gVg2i0/efnhGzwbcBobrBa64L+sy3VksdTOJvpSpJ2ralJeuhPSIHlbKk81O1nw1NeDeWYnQBnHb/PHjUHTYCs7rSGrE3vfeQEfAF/3BnbOzXa+pMw0BfUEIIWdBYNu5otHLl92jUbDno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a/NNsuFQ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF87C11401D1;
	Wed,  2 Oct 2024 18:55:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 02 Oct 2024 18:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727909740; x=1727996140; bh=jrXYY+Za4EOM/dW2KzkWNeifL9zg
	t+DHBBMyVk28hcc=; b=a/NNsuFQ2CULd90JQPvjzF/Wu2oW57n8IbPWfT0dHoub
	xr1tTAoG/FRcg5GwqkTk0WJcIAzzHwQPhWDyKUo8e5qr5BL5fiNyqltwddm32WKL
	RZKUmGMgVZuZ6ENQO2JkryiMvQk28WbX9LC4euIgjbL1QlNSML47PwtR+AOKFZGx
	DsdAJe2r/JObRIU8dCWi3KlTrmpKPjVJMwIy7kalXh9zuM/snZPcwghcKm17gBAb
	8ziMY4rsjSs9crGUZbZgvKEn1wKFl5FR8QYZjw6ykyc0RRAh2OboHF6JIMAVAvOy
	yHpeIByfo19tDuk7oSidPQACCA5+ha4kgRBOZJBCCg==
X-ME-Sender: <xms:bM_9Zq5MLqLrru7sUve6bX9Nvt4MhtNigfiYWkcq7BtPVUuUQxmpVw>
    <xme:bM_9Zj4W-YKgV3zBbCfT5e-jZr3hUVSrPyq_R39TaxbkwDK6pGA0TIgggx4Sg7E8m
    q1G23YG1Ff_F0-6MzI>
X-ME-Received: <xmr:bM_9ZpeEkspnP7BE0aFmmA0wgwBeDeVn7_C3arPe64B4Jq6olsyETU2phgjzeyHWk5wGperbEHr14I5w1RStxVTwhv4IvZvhdnk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvtddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecu
    hfhrohhmpefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrd
    horhhgqeenucggtffrrghtthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeff
    ffdtgfejveekgeefvdeuheeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrgihhigrug
    drrggsihguudeisehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqmheikehk
    sehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehskhhhrghn
    sehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:bM_9ZnKKmVVvwwcN-AyeglFKs25dtUR4lPGgqQwsc2CZyiF9bB3IFQ>
    <xmx:bM_9ZuIiHh58I8My8deVSvqt8xV2XOgg5M_BW7YBL3RGK2SSwtcQkA>
    <xmx:bM_9ZoyCaosEmqj46PqLCw8TZZzXWzUjjs2H9UMA0aqf65ee8VRffA>
    <xmx:bM_9ZiLvUEG5G-KPphevVR9B8UD4IaObe64soSYq9HVr8jwTYsGl3w>
    <xmx:bM_9Zq0ttNdKaoOEeb5FyTyMEcLZWFJS8gImlIWWWP8uBpknKL9WgOzz>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 18:55:37 -0400 (EDT)
Date: Thu, 3 Oct 2024 08:55:43 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Sayyad Abid <sayyad.abid16@gmail.com>
cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
    skhan@linuxfoundation.org
Subject: Re: [PATCH 0/3] drivers: nubus: Fix coding style issues in nubus.c
In-Reply-To: <20241002132820.402583-1-sayyad.abid16@gmail.com>
Message-ID: <06ffa5a2-f73d-198c-3e7b-178e4fcec1ed@linux-m68k.org>
References: <20241002132820.402583-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


Hello sayyad.abid16@gmail.com

Thanks for taking the trouble to send e-mail messages to so many people by 
use of a free e-mail account.

With regards to kernel patches, can I request that you --

1. Don't run checkpatch on existing code
2. Don't send patches that break the build
3. Don't claim to be improving code style by sending patches that violate 
   code style rules
4. Read the mailing lists and study the development process before trying 
   to contribute

Thanks for your consideration.

Regards
Finn

On Wed, 2 Oct 2024, Sayyad Abid wrote:

> This patch series addresses coding style improvements in
> the Nubus subsystem, specifically in `nubus.c`. These changes
> aim to enhance readability and maintainability of the code.
> 
> These coding style inconsistencies were found using checkpatch.pl
> 
> Changes include:
>  1. Improved comment block formatting by aligning `*` in
>     multi-line comments.
>  2. Fixing assignments inside conditional statements to improve clarity.
>  3. Correcting the use of tabs for indentation in specific functions.
> 
> Each commit focuses on a specific aspect, as detailed below.
> 
> 
> Sayyad Abid (3):
>   Fix use of tabs in nubus_get_vendorinfo and nubus_add_board
>   Fix use of assignment in if condition in nubus_add_board()
>   Fix use of * in comment block in nubus.c
> 
>  drivers/nubus/nubus.c | 94 ++++++++++++++++++++++++-------------------
>  1 file changed, 53 insertions(+), 41 deletions(-)
> 
> --
> 2.39.5
> 
> 

