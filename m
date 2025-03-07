Return-Path: <linux-kernel+bounces-550816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7CAA56479
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8161896FA3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8714F20D4FC;
	Fri,  7 Mar 2025 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5OTLqGBP"
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B356E20CCD3
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341555; cv=none; b=cnhXJGU6GLosLHClc493hIjMETX5w8kQh1vdKa5P5c/wg9bFRu7gvEYS9LpX9dWBwCXbkUls1j5uejlLb+lSDKK/fX5zvBJVHg3Ed4rVqe1uRicrqYSX0+mAOvVCq6XOD3KiFriruvJoRa9t/UlgADbjnaYt1iVIG3wPi8a3inY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341555; c=relaxed/simple;
	bh=5K5INi12zme5Lj5RkL3vo+GTTzP7z17CBnXt5GUjTKQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dZI45kUfz/rXdfuNJ7ajTjLiElbdNFv/A5q5yiDS0DiUCyjcDl781tK0LWG4vdC7+JhdqiVBxDq5pNx2KSImVm3pya7kSkXdegydhN5aOgkvJvozaG3nWMj16hI92FeLKDfHRcWs7spUwZPS6yBmgewlP23QTWNV9IOdzot0ths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5OTLqGBP; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D3FFE1140106;
	Fri,  7 Mar 2025 04:59:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 07 Mar 2025 04:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741341552; x=1741427952; bh=i8NNEtSS6uGgPSArYybT7Jm1I3EtatokgOv
	lA/pxm4g=; b=5OTLqGBPOq9r0hZhRng2rw7/YXWDIwPL8vwQdlUkdGHo4znjKDS
	XRDu36qMdpYR6KASRmGqZY7xKni6ZGmdxhsgBAUpZrdItth4sguMLwceB94WYaoa
	by73vrJQgEbeHTbYhewTkQl/FMXg0FvrOLiaYoGf3clK2wbOX1XPbAHCqjtWksMg
	8ZrtTlXr7rB8kwzqir7UDipux1t6QWYas5m595oXlege7jOyNwL9nyGcgrGpueSC
	wyN0b1xKAVIlzurrw+zE95+ZeltJGrZIe/ve7BpHYO1IeKeQ0oYHa2NWl+6GONG5
	GgN4W74gBvfthLJuURuvo+9K4/feeVJ2hKA==
X-ME-Sender: <xms:cMPKZ5Uc0uUhQ8Ry91QbB2xESanGPFQct-AqpOOtr1C8_IgqIpkQjQ>
    <xme:cMPKZ5kldndf18R4Ug9loNnxznauvQ7eELsl21n0UGgb3x9u3_KVbwSqXiEixz5O3
    kG_QWZ6UhZngZDtSMY>
X-ME-Received: <xmr:cMPKZ1bQgVGkKX-Fb5N9M-UfesrTzlQX-mxmekyUP5LjzdT7LdME5_pHtG54aosn4rGxL2bs5aqZugIrHpj9_S8nUKDPSyBjIls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddv
    necuhfhrohhmpefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheike
    hkrdhorhhgqeenucggtffrrghtthgvrhhnpeelueehleehkefgueevtdevteejkefhffek
    feffffdtgfejveekgeefvdeuheeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgpdhn
    sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehthhhorh
    hsthgvnhdrsghluhhmsehlihhnuhigrdguvghvpdhrtghpthhtohepghgvvghrtheslhhi
    nhhugidqmheikehkrdhorhhgpdhrtghpthhtohepjhgvrghnmhhitghhvghlrdhhrghuth
    gsohhisheshihoshgvlhhirdhorhhgpdhrtghpthhtoheplhhinhhugidqmheikehksehl
    ihhsthhsrdhlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cMPKZ8Vknj279WmJuCBLcZbY54Ezgh-yGmvxz0AokBXhY0dxboGWMA>
    <xmx:cMPKZzmq2YLVEdcl_AsIU3yM6Rq5swhh3rurDlHQkzEXpn7mbIcKRQ>
    <xmx:cMPKZ5dMDyHTdvJ4K3DCf44Rej1xbL0m0n7FUFepmbZUYgbrZA-VZg>
    <xmx:cMPKZ9HXJNKnT6WuRBCGawrqgpQDdsL8m6Huu4vAuFse4CTmlUCMVQ>
    <xmx:cMPKZ8Av8U3Aumpb070ZTJOCupa4ZVa22ljInriGNuoCZysVNt3uz5A9>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 04:59:09 -0500 (EST)
Date: Fri, 7 Mar 2025 20:59:07 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
    Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>, 
    linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: mm: Remove size argument when calling strscpy()
In-Reply-To: <5216B227-6174-4C0A-9126-B8861473A0D3@linux.dev>
Message-ID: <2b60b7bf-347a-9a8c-f49a-db7ce0e19c60@linux-m68k.org>
References: <20250302230532.245884-2-thorsten.blum@linux.dev> <CAMuHMdUonC54g-XSt-EkNbEGxhkOWMxBc87Qtw0MyeXoPqDD4A@mail.gmail.com> <e5e10808-5cca-243b-304f-4aa8db1d30b6@linux-m68k.org> <5216B227-6174-4C0A-9126-B8861473A0D3@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Fri, 7 Mar 2025, Thorsten Blum wrote:

> it shortens the code without changing its behavior
> 

Is there some limit on the quantity of code in the kernel that could be 
made shorter by the addition of new layers of macros? The only limit I can 
see is the scarcity of skilled code reviewers.

As for code style, I guess I prefer shallow bugs but YMMV.

