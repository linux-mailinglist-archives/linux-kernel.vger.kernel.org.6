Return-Path: <linux-kernel+bounces-357423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82981997119
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47212286A66
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727351DFD84;
	Wed,  9 Oct 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fl7mVLJ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29F1E04AA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490043; cv=none; b=PMSEn0iX2lezDZAJbEUFb0uJMJVBBFY0LDIGuzWS5O1yGwRJfS3JIn9Z7LYtv9xk2ZI9gF0VPTWtiAD1r7YD5S7ytsx60Qssc0g+l1JqVH2khgKwuRWpS4hUGOkT/+X92DfyGWevat+SC2XhB17GuxwwVX7VCuHRB+6cvZhURQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490043; c=relaxed/simple;
	bh=mjLy1BpseUfZ/WjYhSF9y2K7scOJI2maFCdB5EyzQ4g=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U+MdaG8x0wfqfkuRcX8HxDhUsZ5S6v6uywjnhJ5D9aEM6LaVvke1jXnwLnOtZ4cm0X5+Mw04tQbPzogFEKF8OfV16pOpHqNSPA7Nm1VizyqihWqb3YaeKRpl7E/p1oBzAhRdCZZAxkk1Q29KzbRglvCDpGKlcgOe61d0ZNh70Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fl7mVLJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99260C4CEC3;
	Wed,  9 Oct 2024 16:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728490043;
	bh=mjLy1BpseUfZ/WjYhSF9y2K7scOJI2maFCdB5EyzQ4g=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Fl7mVLJ+T1kxTmEIewtxoETgyH2wG7sZWaodm1frZXk1IwWJRJlSCC4kCQa7fHT/p
	 RRjDVnQFZAa6pIXEjCuhcI2LQaORGihj6H+1fJPoTYY/t/OJaTc/BGw6mxMBhgBL5r
	 xBnMG5BVyjgDJuOttCe7jOcbyPVW7pmQn++RZ3sMiuCBktYMuIA+Uz9Jy+qoXlhybZ
	 pJSEoAr+Ccof2DgcehB3Ul0nSUGHPOzHEWZcs3/ad+vMmH64ohdp2zQqLB9MsDAMoA
	 gqYzexiITgD+ZvamIwBPxTbwRLpsfPckn90AHxM+bMWVMjDm0KGhNABRvxwq6AgH5v
	 zPRPW0sRM0uGg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
 Masahiro Yamada <masahiroy@kernel.org>
In-Reply-To: <20241002151539.43762-1-masahiroy@kernel.org>
References: <20241002151539.43762-1-masahiroy@kernel.org>
Subject: Re: (subset) [PATCH] mfd: wcd934x: replace MODULE_ALIAS() with
 MODULE_DEVICE_TABLE()
Message-Id: <172849004231.661391.3358849014171986534.b4-ty@kernel.org>
Date: Wed, 09 Oct 2024 17:07:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Thu, 03 Oct 2024 00:15:32 +0900, Masahiro Yamada wrote:
> Since commit b4b818305578 ("slimbus: generate MODULE_ALIAS() from
> MODULE_DEVICE_TABLE()"), modpost automatically generates MODULE_ALIAS()
> from MODULE_DEVICE_TABLE(slim, ).
> 
> 

Applied, thanks!

[1/1] mfd: wcd934x: replace MODULE_ALIAS() with MODULE_DEVICE_TABLE()
      commit: d64e5e0cda561d627bd0f2a1a4c7de9d842159d7

--
Lee Jones [李琼斯]


