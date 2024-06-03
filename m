Return-Path: <linux-kernel+bounces-199785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 521A68FA5F1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDEA1F21A24
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BE11386BB;
	Mon,  3 Jun 2024 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFdaskgv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40BC13CA80;
	Mon,  3 Jun 2024 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454609; cv=none; b=kpZ/edI8AwckE64bQ0lpiljSRZvINiXf9XOe7bHDCllTejEx2f3wozuxphi8DHpSneUnmHcfnGTd8cA1LwR/UxcPAKqodixwtFzUbFNw1R0EKsQW3mo9jUCe8fjxgc9Ea3JveFfiooLCkRNFWMrYXZKNx2PNZ8BbpF0ERX1hBzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454609; c=relaxed/simple;
	bh=2Lts55Qq73NAe4bdOXvT2eGFXJrChEFdxylEwk1f/7U=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=AB2s1a2L4NYJk7zWMRieOfzbV1u4CsR6K/njdf5oXpZZ5ncfUqakb1UJjkCzKAObsDcok2uiiVU17XbDEBF2NSbj5cqn/W+20Mey8SInvWJmaYJ2O+sn2cdmpiVK1QEnd/mytwjhsyrTsvyJTINiUPvCo9jpmdfM0jVEXJA0YJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFdaskgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74520C2BD10;
	Mon,  3 Jun 2024 22:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454608;
	bh=2Lts55Qq73NAe4bdOXvT2eGFXJrChEFdxylEwk1f/7U=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=pFdaskgvFZ9vxuPu5MDEngXAjsLApT4qcLApX3X18PwhctzA3uAP7RmtQ0Oh/4a+1
	 ftUhImICQCBHerTE7nbEGydwcbkuzv7XwNkS/un2XhJeSdNtyLWY3cXwJOwEAMgUSX
	 KtfH1mfFqv6Xcr0QEVkNO5w67va64rU0iP3YPXB/7h0mUH5UqmHafvPGMb/NURwGix
	 Q6HHYn29COmut4wSBG4aAO9KuMKbeXzTl2E76rMdrRCQKtCTdTBBoHsT7fdcrwxekQ
	 Itb2RESPRyBhfvZ+uxjNftziX0LXkvH/GE0NgYTjlGCcH8ChhhUW+D7Q7brna/B89B
	 vshOkrDUkg/BA==
Message-ID: <6c67a5095998e3814b027480fdafaadd.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240602-md-clk-sprd-v1-1-de0884ea6fc7@quicinc.com>
References: <20240602-md-clk-sprd-v1-1-de0884ea6fc7@quicinc.com>
Subject: Re: [PATCH] clk: sprd: add missing MODULE_DESCRIPTION() macro
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Jeff Johnson <quic_jjohnson@quicinc.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, Michael Turquette <mturquette@baylibre.com>, Orson Zhai <orsonzhai@gmail.com>
Date: Mon, 03 Jun 2024 15:43:26 -0700
User-Agent: alot/0.10

Quoting Jeff Johnson (2024-06-02 08:26:47)
> make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sprd/clk-sp=
rd.o
>=20
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>=20
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---

Applied to clk-next

