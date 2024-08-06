Return-Path: <linux-kernel+bounces-276028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7446D948D77
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0776FB23DD3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1621A1C2326;
	Tue,  6 Aug 2024 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=angelogioacchino.delregno@collabora.com header.b="Bu1tmmLJ"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EF9143C4B;
	Tue,  6 Aug 2024 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722942648; cv=pass; b=R6RmdGs5CBm2G3L5XAPSlzRfbtRxaZRSCQa/cdwOTiK0Dc4VuYEGWR3fKg7/CUr+pRdMsmCS3LJQfYPmHdEPAv6lirsf0OTjSZo+j3ORwKXyCAkR6rQDYKoC0PxgfFPhwqXZdOUbHzfSamEOk5ra+fXSFpln4U6WYgoQrIfStsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722942648; c=relaxed/simple;
	bh=e+wbgqfDDNcxGYxQDkq0XzOj/7zncsCPwd1dGezPoB0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LWgRreHjZlIZVtJM+ZSFkHGB+qurDuigKSENvDvToQY6MEvyypXi3eleJnFlRK9Ky0MLqQAw8LH86POCyaGiLmFS2Irgj4hQk14HUKsA73gCmlNEnMpupcfSP6Wdxe1yf5fcauG9Wwgnccp6JHYNkPsuxk0CekoYMW9gluvR9nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=angelogioacchino.delregno@collabora.com header.b=Bu1tmmLJ; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1722942636; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c8k9o4I1y1cdLbRmlbfHGPW5WEuMiNw87gnTegnFS3PCN8DSi+ce9tRESQBV2dkZ2nNFTnQfqJYrYaQsx1O/Dx8WK2ibEF2zOJY4qVdpb/aQfNRsyUd64OJ70H0TeiK4BW0HG7ExGts7iJSbV6ffDed9dVl7/8l87Na/VIQgMv4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1722942636; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tldYjeD6HK9bxcPewewNG/XgAT3v0NaPxmuaG4zO1Ko=; 
	b=QPdiKFX+d0KJIe8be/OCSMB2W+pQzgmKS5cX2+/tutIA+u6qZdr8fhr+pAPzsFdFMFURNyBa2WBYvcIPrjDJd3O7K8snzlK/ciYR7NSyk7GD/MU1jWUzxIcedFE0HIYrKRn1gujauE8ynYUAX+sDI4arS9pgBzJ3qVFL/Xu2RHw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=angelogioacchino.delregno@collabora.com;
	dmarc=pass header.from=<angelogioacchino.delregno@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1722942636;
	s=zohomail; d=collabora.com;
	i=angelogioacchino.delregno@collabora.com;
	h=From:From:To:To:Cc:Cc:In-Reply-To:References:Subject:Subject:Message-Id:Message-Id:Date:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=tldYjeD6HK9bxcPewewNG/XgAT3v0NaPxmuaG4zO1Ko=;
	b=Bu1tmmLJKycqTbsqWlfb1y8OozfcbVHAzzScDxR3k7dTCCY8VueULsUP3mpJCeo8
	r8zwZEllQXU85Bm/bGxJrZztDfeXvI31Uyd6seKhwSM91z2j5UBnh9F3c8z+QknVQ2F
	XCTj36mbY+bdAJsnkobMvdejrFUrPD51NtFiHjCE=
Received: by mx.zohomail.com with SMTPS id 1722942635898618.9204526741114;
	Tue, 6 Aug 2024 04:10:35 -0700 (PDT)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Chen-Yu Tsai <wenst@chromium.org>, Fei Shao <fshao@chromium.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240719045823.3264974-1-fshao@chromium.org>
References: <20240719045823.3264974-1-fshao@chromium.org>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186-corsola: Update ADSP
 reserved memory region
Message-Id: <172294263338.126161.6244258910224268535.b4-ty@collabora.com>
Date: Tue, 06 Aug 2024 13:10:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-ZohoMailClient: External

On Fri, 19 Jul 2024 12:58:04 +0800, Fei Shao wrote:
> Corsola firmware reserves the memory region of [0x60000000, 0x61100000)
> exclusively for ADSP usage.
> But in fact, a 6 MB "hole" of [0x60A00000, 0x61000000) didn't get
> assigned to the ADSP node in the Corsola device tree, meaning no audio
> tasks can access and utilize that memory section.
> 
> Update the reserved ADSP memory region to fill the gap.
> 
> [...]

Applied to v6.11-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8186-corsola: Update ADSP reserved memory region
      commit: d03521e6c18f62876b3b5c1fbf37e0d8ab9fd1b8

Cheers,
Angelo



