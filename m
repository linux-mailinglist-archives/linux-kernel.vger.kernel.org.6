Return-Path: <linux-kernel+bounces-173345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0849D8BFF25
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A201F27B7B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B3481ABF;
	Wed,  8 May 2024 13:42:04 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B978126F1D
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175723; cv=none; b=DCdI9tGAElxbklUG+GDFRCJqlccv0DqczF+8+/nxQ43CV/ooBNO4CMbrwwgJgOIdczZHLeMgVD6Bhvoky+KX7jRI6Z7ExrUhOk41SlREqr64J0woDrzmFs1FJh6lvcZv0pngTknrArFhmTTFuqLvssxknrnlQLkrp2hxaZ9PRYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175723; c=relaxed/simple;
	bh=eFW/4Gk0pdiSd87mHE0eU3KZy0dYMBoegeYeeV4FIVw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qJTpCtqPGqGC5n38ZSCHxGZPg34aWlLLXNngNEuHmttXk4A1u4nGE41W4GXQaQxd6owz9IkkeDn6GNwlSg2s/9tUJdu1nJPRrdkRueAMm7GhgJJ+9MBb1o394l8qKpop3+zXAA2L3T+hcB5vaOsk2qsIHr7j0s3FE0Cn1pVNo0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VZGXT5124z4xM0;
	Wed,  8 May 2024 23:42:01 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux for PowerPC mailing list <linuxppc-dev@lists.ozlabs.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20240503121012.3ba5000b@canb.auug.org.au>
References: <20240503121012.3ba5000b@canb.auug.org.au>
Subject: Re: [PATCH] Fix the address of the linuxppc-dev mailing list
Message-Id: <171517558547.165093.12053711566803170487.b4-ty@ellerman.id.au>
Date: Wed, 08 May 2024 23:39:45 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 03 May 2024 12:10:12 +1000, Stephen Rothwell wrote:
> This list was moved many years ago.
> 
> 

Applied to powerpc/next.

[1/1] Fix the address of the linuxppc-dev mailing list
      https://git.kernel.org/powerpc/c/fae573060c8da4d84a2551c6753d272abfda8ddc

cheers

