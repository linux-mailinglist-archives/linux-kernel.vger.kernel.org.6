Return-Path: <linux-kernel+bounces-173339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CE98BFF15
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7464283372
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF0086243;
	Wed,  8 May 2024 13:42:00 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBC484FBE;
	Wed,  8 May 2024 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175719; cv=none; b=c1eqLQds/6hcBHKOVX2pjJRTMzpvibEEnfvqiaRoHYvn4ZiHjag0Yy1HZa7vzvuV824QyL4TLLj8kB1Kb1Hq9ZsYTJkpN2kdUX1T8MUTHtaO8da5K+vnIFdh5FJlzKZCMDiwgAQHR6gMYY7xbTKW4bQLYCgFnVC9UY+pe6RHALU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175719; c=relaxed/simple;
	bh=ZPf+rSnPTRyUxIk56yCEHcfZHAeg+uj08XJt6D76TLc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TLastEBZzA1BvID+sDQdoMw5HOGwb2oVJlerMpREGRyTxsLCqxNZw6/T0yVOFOarYa3/uFs/cI4S4GrDIpJkL6fMfRNp/PPfgLFx4A5gzBOp6bdC4XYNfOCBKl/qAIKYWIqmAAHodPZ4Vn0JocFXTV4ADypembfT3A3bmRttJVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VZGXM34nTz4x80;
	Wed,  8 May 2024 23:41:55 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Ran Wang <ran.wang_1@nxp.com>, Zhao Chenhui <chenhui.zhao@freescale.com>, Li Yang <leoyang.li@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Jakub Kicinski <kuba@kernel.org>, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20240119203911.3143928-1-Frank.Li@nxp.com>
References: <20240119203911.3143928-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/4] powerpc: dts: add power management nodes to FSL chips
Message-Id: <171517558555.165093.3578824568292116308.b4-ty@ellerman.id.au>
Date: Wed, 08 May 2024 23:39:45 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 19 Jan 2024 15:38:54 -0500, Frank Li wrote:
> Enable Power Management feature on device tree, including MPC8536,
> MPC8544, MPC8548, MPC8572, P1010, P1020, P1021, P1022, P2020, P2041,
> P3041, T104X, T1024.
> 
> 

Applied to powerpc/next.

[1/4] powerpc: dts: add power management nodes to FSL chips
      https://git.kernel.org/powerpc/c/b12ba096b89084d1e2d6ebdb71b852eeebef95d3
[2/4] powerpc: dts: p1010rdb: fix INTx interrupt issue on P1010RDB-PB
      https://git.kernel.org/powerpc/c/9c8dc6f34351cd0c6a2ef83be2266f7dd67c152c
[3/4] powerpc: dts: mpc85xx: remove "simple-bus" compatible from ifc node
      https://git.kernel.org/powerpc/c/0bf51cc9e9e57a751b4c5dacbfa499ba5cd8bd72
[4/4] powerpc: dts: fsl: rename ifc node name to be memory-controller
      https://git.kernel.org/powerpc/c/acb354fe97e5aa6d9534b601ce18ef7866f25c4d

cheers

