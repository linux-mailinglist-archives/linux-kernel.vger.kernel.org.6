Return-Path: <linux-kernel+bounces-318060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B0296E7D3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FF01F240F2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95F0335A5;
	Fri,  6 Sep 2024 02:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ry0f3xrC"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A090A3FEC
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 02:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725590636; cv=none; b=rcJqaTWNNUTl2DCHuoF/MlztIFkdjylkFZXOy4LGH/mTpep18vKDC2QMeSjVWVfqPvE8SClONQpVCS68diNsbTMfl0fkQ4TjvFw2Xpc5Z9Jel8jjQcFP4h53jBLdQtOU3NH8mFaDqh9/B0CGh/GXsOQAS8UCROCXThtwiPw3DNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725590636; c=relaxed/simple;
	bh=Ijk3Ilal+Evxlq6LFalNGRpxoP6VV+TYx1848gi9/oE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OxGAyW01yrwJ/BwLuNO4hgj5ykzcgNUaxHxUqOYPGeSwElDNrp315ic05aMx11Uem2aBDDuxQ/+zwAgAAoWhv4G7tr9QLc75GRJvxtfOOKjF8zY5uSyh/GduAZiidodP2oRsG1S4qmzwwlDgOThG1FnE340s0G6ci8q3XNdkPF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ry0f3xrC; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725590631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ijk3Ilal+Evxlq6LFalNGRpxoP6VV+TYx1848gi9/oE=;
	b=ry0f3xrCphvWd3rKp3PbjjnyZczptd45axBPzV/PFtzZ01aPuov2mmfOk+bf8h7Mfne1r2
	loLAgQoXuntft38GiSJdyPSr3zJeHr1OP0qG/0qkElWCKnYil00gmmajNSaomVnsM2yUYo
	RFFnQyriPXArqB/UBbDzyUVF6x7KcQk=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH mm-unstable v1 1/3] mm/codetag: fix a typo
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240903213649.3566695-1-yuzhao@google.com>
Date: Fri, 6 Sep 2024 10:43:08 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4CDC0156-0AEB-4CE9-ABD3-A9E5640FF56B@linux.dev>
References: <20240903213649.3566695-1-yuzhao@google.com>
To: Yu Zhao <yuzhao@google.com>
X-Migadu-Flow: FLOW_OUT



> On Sep 4, 2024, at 05:36, Yu Zhao <yuzhao@google.com> wrote:
>=20
> Fixes: 22d407b164ff ("lib: add allocation tagging support for memory =
allocation profiling")
> Signed-off-by: Yu Zhao <yuzhao@google.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.


