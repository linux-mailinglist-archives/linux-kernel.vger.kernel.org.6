Return-Path: <linux-kernel+bounces-370081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8415D9A2712
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382CA1F220C0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7B21DE3B1;
	Thu, 17 Oct 2024 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kJir5jTy"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249711DEFD2;
	Thu, 17 Oct 2024 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179484; cv=none; b=LAwXJXMnhiw3pMzEdOSqqTEYIY7yhxyjQQoOJT0WcY4uxAqV6FLXEMncvbVuwuEVt1vQ+bM2dwMr12ZkgKj7mrQ5Sq+e7izWEJgJsTMnEyIeTCiGDyJmMDljfAtFLYfz+Ov/cJN6/ARIRiD65zTMzhe6oOlRlIjMXxDnSDnF8Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179484; c=relaxed/simple;
	bh=KBIFieMUFg56WKUbGB9+0vfYhWHpL/gf2LHURw3IzRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ejPtZw1LFdJi7t6lNAC5jK2eqNMDnmdj4nA823kDTnmuiuyACZX0Ac4OWauGunjcQV+Fo8S5lvS1cCQ6M0FBRCPehF1VuhZfFOo8qj2X3sSzPI/sRf+2LdXCKIB+mS/chGj4r6dB77a0j3oQVNP+W8b1EHPVoHkHPDwGVrF8imk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kJir5jTy; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 39B0342C26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729179482; bh=1tMzlbriasC5cT7cD/cXSyjzn4nFHarFiBq3lFFDCGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kJir5jTyp/3DZJ0JiWofTnpUtKJPRKixwpxtaqUPTuv2HgH+3Kj0khhPNjQglYOnf
	 g5Tns9fOCndobpFjacwU5AHQjiZ0Xp1jeq8H5nDrt2c4THzCO0TUexEYozNmpkHtLZ
	 wMis+4zJJQiji+Vq1RhoTCx1fJ32QjwHXUR+YlOBdMpuAjiqDfyzPU1/byWxx5MXz4
	 7oxWS/KEXQuSATBL3sUzDZwDxGOIVjLSWyDfBjO5AuiImIqZV+M1k5geL71JSWeLe7
	 cd+vLlQnDouxhs52nzdbt2LPuWWDxqmd+/uaTpju/X1FptUSX8oSdjLIoEPtXNUlvN
	 KO/1peV17D57A==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 39B0342C26;
	Thu, 17 Oct 2024 15:38:02 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Eder Zulian <ezulian@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/core-api: swiotlb: fix typos
In-Reply-To: <20241014224026.1838525-1-ezulian@redhat.com>
References: <20241014224026.1838525-1-ezulian@redhat.com>
Date: Thu, 17 Oct 2024 09:38:01 -0600
Message-ID: <87bjzi3fl2.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eder Zulian <ezulian@redhat.com> writes:

> Correct references to swiotlb_tbl_map_single() and
> swiotlb_tbl_unmap_single() in the documentation for swiotlb.
>
> Fix two small typos that went unnoticed in commit c93f261dfc39
> ("Documentation/core-api: add swiotlb documentation"):
> swiotlb_tlb_map_single --> swiotlb_tbl_map_single
> swiotbl_tlb_unmap_single --> swiotlb_tbl_unmap_single
>
> Signed-off-by: Eder Zulian <ezulian@redhat.com>
> ---
>  Documentation/core-api/swiotlb.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/core-api/swiotlb.rst b/Documentation/core-api/swiotlb.rst
> index cf06bae44ff8..9e0fe027dd3b 100644
> --- a/Documentation/core-api/swiotlb.rst
> +++ b/Documentation/core-api/swiotlb.rst
> @@ -295,9 +295,9 @@ slot set.
>  
>  Fourth, the io_tlb_slot array keeps track of any "padding slots" allocated to
>  meet alloc_align_mask requirements described above. When
> -swiotlb_tlb_map_single() allocates bounce buffer space to meet alloc_align_mask
> +swiotlb_tbl_map_single() allocates bounce buffer space to meet alloc_align_mask
>  requirements, it may allocate pre-padding space across zero or more slots. But
> -when swiotbl_tlb_unmap_single() is called with the bounce buffer address, the
> +when swiotlb_tbl_unmap_single() is called with the bounce buffer address, the

Wow ... that seems like the kind of function naming that is just
designed to cause errors of this type.  Applied, thanks.

jon

