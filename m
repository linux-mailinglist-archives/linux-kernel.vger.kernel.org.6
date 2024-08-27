Return-Path: <linux-kernel+bounces-303837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF319615A6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17AB72846D6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C3F1D1730;
	Tue, 27 Aug 2024 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIrjBWxZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001731C57B3;
	Tue, 27 Aug 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724780412; cv=none; b=mQjnLHnEnyf6y0YPR+2RIyCqADgr/pQ6nN1SpOMUzP6q6jTEQpSYsuR9AcuqeFMDRiCQK/E+5P57mKUNOGeaH+BaduA1Zn5wQctbMcWcuYOSj9qHm7M1+9+HLcg2ECTM0065JZ6temMzU+8KC8SAasFBZDao8zsxsVutSVJyPQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724780412; c=relaxed/simple;
	bh=KAMT7cmENFsM1Mu8hFlu4x2XYmvsywTQuvh0O2Km2e4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ceeDqx+nr1I+A7LDP0+mK+h+hZELbOt9bivIogmzGNsF063QJuqB2Xo6+d7+7Kw3D74UcHQesWeLMEupDSPuLsXN5he8c8DQ6fON7HVuub6HG4vP2iTX7yOeIVBmSiEumBPvKFyHw7UOEDZnpQFz51N9iPHw0skeW6+2+MsFC/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIrjBWxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78137C4FE82;
	Tue, 27 Aug 2024 17:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724780411;
	bh=KAMT7cmENFsM1Mu8hFlu4x2XYmvsywTQuvh0O2Km2e4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=lIrjBWxZfENFSK7XT5DGe9SEN6tK+2QScrmC5T9xIOudWsTjcaYGDYxsyjPRMHuxv
	 EUDAl1C0sloxOjo6r6rqETMDlyQ+esTtv3Kpp/8/Uan+pHqSaNLZY1xtOSw0qdMMYS
	 ENskB9171VfmxpmP4TNQnpPwuRhhh2f+GbUVE5EqhBRqzzIWe2IdSabqw2ibP0s4wb
	 jt4b/4x4zf97BnE11hX1/2BsAasOQ+gFLmq5xZ9zVCYn+4fdwNc+Rf5hMTJ4gJdFCf
	 IZTJuvPhGQr3uQSSOazJO+PQS/G+BKg0L4Jba+yRcG3LfR9N4u33yiRFcG+gQxJu86
	 /9yaOBjryf/NQ==
Message-ID: <0f670049f3110f2be74f28f09e277b4e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <tencent_EC61FECEE03D06AE0D29C514581901BDFB09@qq.com>
References: <tencent_EC61FECEE03D06AE0D29C514581901BDFB09@qq.com>
Subject: Re: [PATCH] clk: Delete init for local variable "best_crent_rate".
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, jiping huang <huangjiping95@qq.com>
To: jiping huang <huangjiping95@qq.com>, mturquette@baylibre.com
Date: Tue, 27 Aug 2024 10:40:09 -0700
User-Agent: alot/0.10

Quoting jiping huang (2024-08-27 10:21:10)
>   I'm sorry, my last submission may not expressed it clearly, and there \
> is an error delete. Therefore, I would like to generate a new patch and \
> explanations.
>   Actually, it is, the local variable 'best_crent_rate' is only used in \
> line 2355 for the judgment 'best_crent_rate!=3Dparent ->rate'. However, \
> if the "if (clk_core_can_round (core))" branch condition in line 2306 \
> is true, the value of the local variable "best_crent_rate" will be \
> updated by "best_crent_rate=3Dreq.best_crent_rate;" in line 2319, otherwi=
se \
> it will be directly returned in the "else if" branch in line 2325 and the=
 \
> "else" branch in line 2329.
>   In summary, it is unnecessary to store the "parent ->rate" value in \
> "best_crent_rate" in line 2301.
>   Thank you for your precious time!

Please read the docs on how to submit patches. Especially the part about
describing your change[1]. For example, "best_crent_rate" doesn't exist.
Also, look at other commits for guidance on how to write your commit
text. Thanks!

[1] https://docs.kernel.org/process/submitting-patches.html#describe-your-c=
hanges

