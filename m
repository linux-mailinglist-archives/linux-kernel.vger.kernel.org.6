Return-Path: <linux-kernel+bounces-384552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B1D9B2BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67021C21D93
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE21E193404;
	Mon, 28 Oct 2024 09:40:04 +0000 (UTC)
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [195.130.137.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB24D161320
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108404; cv=none; b=flNO/MO6SayMsknh2qtw72PxolJxkV6UORnNKDxLd76AzfVoZ7azPyKPNbBrhlb00bpx9vURSbhaFIpG36MjIuJD572fH0o7Vi2q6tpeYiPpPQs79Kg7LiOegxlvgDBGh2E4nkzpw1mK5oQvdvF95Yx0yZWkpUSXhEDCuKK3L1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108404; c=relaxed/simple;
	bh=bE0hL9OfSw/KjCIFXmaOqgO3sbMZTevxLb4ytBj51zM=;
	h=Date:From:To:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VNrnTDAPAB0QLXB3OPqa/yqHiqBq91mXwiBTsXbOTjCK7CPhh/vWYajD3L7mGw3GdKPl+dyMiZoXIML9crgQppo3TiOTve5kdZEaB1RHCzll37f8AamZPHZ2BBSk8pe/HCJ44QRS/w17ABS+MeJ/++5k4CwAaQ35s9MwlovBVvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
	by riemann.telenet-ops.be (Postfix) with ESMTPS id 4XcSzG2kPPz4wxxv
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:39:54 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:36d7:1bde:6f22:dc65])
	by baptiste.telenet-ops.be with cmsmtp
	id Vlfn2D0031znq4j01lfnlQ; Mon, 28 Oct 2024 10:39:47 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t5MDz-005huJ-3O
	for linux-kernel@vger.kernel.org;
	Mon, 28 Oct 2024 10:39:47 +0100
Date: Mon, 28 Oct 2024 10:39:47 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.12-rc5
In-Reply-To: <20241028091828.3430883-1-geert@linux-m68k.org>
Message-ID: <dccd8d19-619-d797-3b72-9920f9355aed@linux-m68k.org>
References: <CAHk-=whHB3RxR15Xk8Epah8ZrRJi-7ZevSu6kBp0MFtjXEvM-w@mail.gmail.com> <20241028091828.3430883-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 28 Oct 2024, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.12-rc5[1] to v6.12-rc4[3], the summaries are:
>  - build errors: +4/-0

sh4-gcc13/sh-allyesconfig ICE crickets

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/81983758430957d9a5cb3333fe324fd70cf63e7e/ (all 194 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/42f7652d3eb527d03665b09edac47f85fb600924/ (all 194 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

