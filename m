Return-Path: <linux-kernel+bounces-319488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F259196FD44
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 23:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B532877F1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CD4156872;
	Fri,  6 Sep 2024 21:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G6PRxXv4"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0B9156861;
	Fri,  6 Sep 2024 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725657852; cv=none; b=IQlUQZAhuz8TkBYx2bq6nEMXCeNI9TbM5hfCwMeUdoRmEBB9L3rjCt7E3rl1JdAXfC39WPq9knPW8ppdZ7w7b+EVNQmLcGmJIcjeKfLV6cN9vxHEsSTVPjc0uXRwIl/MxSlHZ4Z9ksuOe3f5ID5MyoX6mPMybTz74VYDhwKZrWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725657852; c=relaxed/simple;
	bh=POyHvh5jBdNKAMswZTPKyPSJD46HSvOVie/HW8PnVGI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KIkrGj7A/VtMzlXYLsjshynaCM3+xKUeEk1hUzIBMAU/0vxjdzR1lO68rBnzclBrd8ZekakROsd5r4AoYCdMRoKhdq9kNYdYMNs0zwpgXt9FJXeHFJ2rDxsJfQRDJrzU/w7fRcMbEJLOcLGYK0HIpibmYFiicR6+uTOPXdYMzDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G6PRxXv4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=POyHvh5jBdNKAMswZTPKyPSJD46HSvOVie/HW8PnVGI=; b=G6PRxXv44pAwraFVu3et1TPQ6/
	gFFnS1tMlLJTSqWE9U6ucjwuqMGcCD3nPZM93pPvsVam/KwYFZhV7ne2i/qCRR1bUUf3fc8TfV16F
	PL2QpfcQ9h4Ucl7FTh/8cTbBAEZ45skgQyV9rVsITNShRWdSlIvtROmGFrVYTTfO9ZUQsbRHu0yH2
	UCDWoy23oJau8uzuhJkPHFinR3f8mkkzpgmwUHJm0ss3hIW4x1zc4WMSxhI+7e4lzytUjMxKv9A3t
	et7GL40ZzTxqlB9JvLgvyX7qaqvtuyMKApucq4AakL77dQ77m7Qb2rT1Ph5P6LCzusv4lwEX3KnIh
	G9auOEtg==;
Received: from [129.95.245.248] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1smgQg-000000002lA-3yZ6;
	Fri, 06 Sep 2024 21:23:43 +0000
Date: Fri, 06 Sep 2024 14:23:40 -0700
From: Randy Dunlap <rdunlap@infradead.org>
To: Dennis Lam <dennis.lamerice@gmail.com>, corbet@lwn.net, nir@lichtman.org
CC: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_docs=3Amm=3A_fixed_spelling_and_gr?=
 =?US-ASCII?Q?ammar_mistakes_on_vmalloc_kernel_stack_page?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240906204914.42698-2-dennis.lamerice@gmail.com>
References: <20240906204914.42698-2-dennis.lamerice@gmail.com>
Message-ID: <C4132FDB-4D4D-4014-8FE1-6F853B71F0B4@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Randy Dunlap <rdunlap@infradead=2Eorg>=20

Thanks=2E


On September 6, 2024 1:49:13 PM PDT, Dennis Lam <dennis=2Elamerice@gmail=
=2Ecom> wrote:
>Signed-off-by: Dennis Lam <dennis=2Elamerice@gmail=2Ecom>
>---
> Documentation/mm/vmalloced-kernel-stacks=2Erst | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)


~Randy

