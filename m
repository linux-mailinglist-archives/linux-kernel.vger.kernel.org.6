Return-Path: <linux-kernel+bounces-285459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80444950DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B369F1C21DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4581A4F30;
	Tue, 13 Aug 2024 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ed2VyzNV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F83187F;
	Tue, 13 Aug 2024 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580259; cv=none; b=T7LuMalxnt9wfhczp4SFSzYI9tUF6ROJmTbRl/G2N5i7PNMgJf+fS4oiIQPxyvdZUxXNhR7vR+fGy3xyJHifLY8JC0H0z1saQ2+wJZTAGlO1e4kfe9jxStUYHwQ6As/u9lvAK/hoIDH3OeDSXkXL3MH+UD5U+XbsSb1Kul3QGwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580259; c=relaxed/simple;
	bh=Cs7xOkrhpZ5qmTwoQLrm+Io+QpnUp8KwzHFAQd7BwV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/fpiJnF0Ye9KFPNhLffZ7XzKVn+P7llHAb4awCKtFi0Nzgco6R3OcMAwLgROTfIUCBQemPlUvYIy4/8GnHqAqI2hzrriqnNtACEUPQcee2+RMmHA6xg3dOYAqnjDftvVI9gQ/9vTCv17CYyFD7IoDPUKoQXxVZ4nl2/k4StpVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ed2VyzNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56F3C32782;
	Tue, 13 Aug 2024 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723580259;
	bh=Cs7xOkrhpZ5qmTwoQLrm+Io+QpnUp8KwzHFAQd7BwV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ed2VyzNVPKw/se85UOkvNYgwqEdujydXUJZ37XNDMj6+DDS6vdEXXfU4k4zHFcSbS
	 N2XXe+23QWWyGxO7PRAIP/cQmrNDwD87tyVhGKqqVmIokKffrnj7kiYeFegF1MfJZn
	 oMCrZKjGSx32bh5yWyJEsCtCoLLUZK78RCBsebYkgo4uguDTSUsFflxPwFFurj8G61
	 MroRCA7SrZGeCzJsA4IzYdlBeo4dRWSKr61+1cSoHM4E/Ifo5Pi3pdHl2cVDk/7y9V
	 IaTMFV27bubmugPvEca3tZ1uWSv+lmv6gQlPXy2ebYHmd5xItxC2gwaXfQzh3iKnBn
	 MVrIhY8lDaPKw==
Date: Tue, 13 Aug 2024 14:17:37 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] dt-bindings: timer: fsl,ftm-timer: Convert to dtschema
Message-ID: <172358025583.1800144.14010787054165854415.robh@kernel.org>
References: <20240730171336.99090-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730171336.99090-1-animeshagarwal28@gmail.com>


On Tue, 30 Jul 2024 22:43:33 +0530, Animesh Agarwal wrote:
> Convert the Freescale FlexTimer Module (FTM) Timer bindings to yaml.
> 
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> ---
>  .../bindings/timer/fsl,ftm-timer.txt          | 31 ----------
>  .../bindings/timer/fsl,ftm-timer.yaml         | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml
> 

Applied, thanks!


