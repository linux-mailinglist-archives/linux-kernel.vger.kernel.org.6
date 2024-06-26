Return-Path: <linux-kernel+bounces-231111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFB691864E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5E81F225BD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2B718F2EE;
	Wed, 26 Jun 2024 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjrD7A0B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FE018F2E0;
	Wed, 26 Jun 2024 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417212; cv=none; b=fREjBm03Lq9vFB8PAYoNtfmGAEewSomc75WtTEzBgUWIB3NMmDRUQbQkhvpwmICWZdONAJaUmeX6SYTsksUnBFY64Kl9qdBH/yeKTKuqhEwsp6bEsO0xp+ylkjo1tFTcwYNYJucypu1kcCGC2ESYH0qHka8SPj3TaNtd7eO+JjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417212; c=relaxed/simple;
	bh=r772ve6fEKb5xT9xB+p3eyAPvGiazB97zwy8oaMSQu4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fgV45q8UnZ7luPpotrjUu7C8fNJ6saHPw9OvnFGhHgv0bgzIoLdTjrdoryWtiermbsycmA6SXKfu59+NDnXzmQ138LsUd738VPHS130uIyaT0Cn4dm9G6NSgeHmQynPJHRovXoAj03zKFCUQo4wuHFm09D0y1YIu9QgJzLVbe4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjrD7A0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48260C32782;
	Wed, 26 Jun 2024 15:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719417212;
	bh=r772ve6fEKb5xT9xB+p3eyAPvGiazB97zwy8oaMSQu4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kjrD7A0BZQbRq2yWERkKrHNh7DxbHZSrxtEB2u2iuusIq2gX1oum5APB0WMfxKQIw
	 nahw/1R4mSnNdJeenb9HlOefZ0mwCvdSUQ10l1+OU4MlLGPgJ78qT62Kd6eFcMPQmh
	 ocuZIy7yQQrPzNc+o0dL7JtACdSMsaEXplIWZEsgp3+0WLe7+BkolI42pvL/E/dQqN
	 76THtNDDc3SHEwe0yjxczntC2/MvFXNZEK2jPyk8Ls5FegpNHwcke73cQ6kpAYq+6Y
	 1oisBZHO92E8uReExnYSMlchhnhLSB/lZytvf5wD1dd9phov+5bIMqxzmHef2dQW21
	 eb7ij9oQPKm0w==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Etienne Carriere <etienne.carriere@foss.st.com>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 Lee Jones <lee@kernel.org>, Pascal Paillet <p.paillet@st.com>, 
 linux-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20240617092016.2958046-1-etienne.carriere@foss.st.com>
References: <20240617092016.2958046-1-etienne.carriere@foss.st.com>
Subject: Re: (subset) [PATCH v2] dt-bindings: mfd: dual licensing for
 st,stpmic1 bindings
Message-Id: <171941721004.2530174.778562710266249921.b4-ty@kernel.org>
Date: Wed, 26 Jun 2024 16:53:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Mon, 17 Jun 2024 11:20:16 +0200, Etienne Carriere wrote:
> Change include/dt-bindings/mfd/st,stpmic1.h license model from GPLv2.0
> only to dual GPLv2.0 or BSD-2-Clause. I have every legitimacy to request
> this change on behalf of STMicroelectronics. This change clarifies that
> this DT binding header file can be shared with software components as
> bootloaders and OSes that are not published under GPLv2 terms.
> 
> In CC are all the contributors to this header file.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: dual licensing for st,stpmic1 bindings
      commit: fcd8646ca6b239aa3752c0ba818a4cda29ee2686

--
Lee Jones [李琼斯]


