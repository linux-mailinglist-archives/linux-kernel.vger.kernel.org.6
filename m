Return-Path: <linux-kernel+bounces-549061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C653A54CB7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7643AFAD1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5879613D244;
	Thu,  6 Mar 2025 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ZYLN+D7X"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3183874059;
	Thu,  6 Mar 2025 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269425; cv=none; b=uDg2dg31FIoqNurQ8E1WQ7zTFGRM1cpow6F0TsX4d6mlX8q3kfPpnor40QHK4d7SZMKTxNAIp1MYa3wt5ye9rrKMGsUdvWpFyVQqlpa7BurHecUmLTGmuhxRBalKpAwVdPHr4MDs8JvYI/1ULAuFP0SW4v5xMZFVJ63ryppGojE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269425; c=relaxed/simple;
	bh=oV9F+a884N+xaC28QLacb3BrnPMfcnJSbpQ7M1sZLFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dd1ct6kUmRcGLTZnhv1kqCCy9cRNOVMcaicsHDvwzNlDA1XUTjz1w0+udQHQ74wnZHW/0rlNzNfB6NuxqWEOoOf4GyAMygH8GRxkC44lZoBz0mQ5Saar2YUTdU4xqeSIRddaGowJvS/n+gztC4DIXOTaYF59/Jpv+72mT3Ha/P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ZYLN+D7X; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oV9F+a884N+xaC28QLacb3BrnPMfcnJSbpQ7M1sZLFk=; b=ZYLN+D7X+5Wzty1yFojtJK6qrx
	Bpy2s2k1EvqZmxUugYeeiz1+KeKSjdq2spIR7VzN0kvnc7o4m4F6lhdYk020KR6N8nuzVw9t10a/l
	iA3wB57zrogFJi/aoAUvJRF/i6SajC68s2V9lVYZtb02vZfeRtg2A7xsaVmgK/SJjIclkjlOU1J1o
	wKnQBo5gSC6RGpi01zGa6E7xc0jMUBPNFpnxVjCefeE3cnXbE88PtYaM4VsGCwp8to08QUqVEx0ls
	/0m68679LrajjGB9XYKtxYqCA/d6Rkin9n2ZI0JHaJDtiKqzgg3eMLnbBZwAXQxy+bGQISnwfWmcv
	gxe+Nzpw==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tqBif-0003YT-8p; Thu, 06 Mar 2025 14:57:01 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, robh@kernel.org, ziyao@disroot.org
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: enable SCMI clk for RK3528 SoC
Date: Thu, 06 Mar 2025 14:57:00 +0100
Message-ID: <3008437.usQuhbGJ8B@diego>
In-Reply-To: <b57e0930-c9a3-4c44-a740-a5623d6904ba@kernel.org>
References:
 <4856313.kQq0lBPeGt@diego> <7020561.MhkbZ0Pkbq@diego>
 <b57e0930-c9a3-4c44-a740-a5623d6904ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 6. M=C3=A4rz 2025, 14:54:04 MEZ schrieb Krzysztof Kozlowski:
> On 06/03/2025 14:51, Heiko St=C3=BCbner wrote:
> > Am Donnerstag, 6. M=C3=A4rz 2025, 14:40:02 MEZ schrieb Chukun Pan:
> >> Hi,
> >>
> >>> That sram is part of the soc (and has an mmio-address), so I'd think
> >>> it should live inside the soc node?
> >>
> >> But soc ranges starts from 0xfe000000, I don't know whether to change =
it.
> >> And all other nodes are 0xf..., except this sram.
> >> Any suggestions would be greatly appreciated.
> >=20
> > darn ... I didn't realize that this is not sram, but main memory :-)
>=20
>=20
> Heh, I think carving out reserved blocks from the main RAM and calling
> it a SRAM is a stretch.

yep, hence going with the reserved memory instead
and not trying to call it sram :-)

And I just saw rk3576 has the same issue, only that there
the mmio area is sitting before the main memory address space



