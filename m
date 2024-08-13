Return-Path: <linux-kernel+bounces-285461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765CA950DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06758B26151
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128631A4F37;
	Tue, 13 Aug 2024 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KioIoCUR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550DD187F;
	Tue, 13 Aug 2024 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580345; cv=none; b=JEogHezqT9o9b4zkmrqr3tZNUbcwSSQKEFuNSsTbTJu8+eBQdBzGWMDMuTE4uozZ7wioiJ0BYwkHv9cNFsnCtM1Tca39s901l/2PtUYldCP/khYHBlDiF0UsjspTgOGD96s/qwuVooQrCuQx6+5J5g7iETDqztuFaD6M8GDSZtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580345; c=relaxed/simple;
	bh=GbqDf3lM/4gmvyOW6KYPTZA8C74oP26+BjcwmWVCdSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRFXwV+v1sey16f/WE72AkZyjFdHzVA/iZ54tp4tKdBG5D8iBP2Lmp9fMRK/LB8g8wEfvUMbYTdVcdKbjc/R6JNZ5GTBOHJKhygZCtKQl30jvgRwiNfaXKI29a50KwnAPstYLXFREQDhTWLmFjSDTEcWyVQelxTDzNY50eFpQng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KioIoCUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2667C32782;
	Tue, 13 Aug 2024 20:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723580345;
	bh=GbqDf3lM/4gmvyOW6KYPTZA8C74oP26+BjcwmWVCdSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KioIoCURffc8KukDHq0/PTyXhjqOx0V6JF1eiaz3BeKnv8IsGYu6fQUldln308NF9
	 VEsABO5N9zIkR73RPgYTYWm44fTU7dVvP1ReelAD1GZNYSgIO0qCtw0WTw8aWEIyyY
	 x1TO8W392Md7l4u9K3li+kxH1fXNm6qmmNpGwzjpP8k9//UK8N/z39nKr6GEh2qB+x
	 CBkaX/hlwwB/h0uo4flE5Pq3o3dFbVSW27Napo5r1X2RQTljDvb9cRhwq6hLgljFiO
	 O2QdWqU366Mv50ljAD0D+0ftBBxxs/rLAsdOxiJIZymympUXJ4zmCMX1xKLVEqCJvJ
	 CYYV+2EtaYZzQ==
Date: Tue, 13 Aug 2024 14:19:03 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: nxp,lpc3220-timer: Convert to
 dtschema
Message-ID: <172358034005.1815551.11101526357860317715.robh@kernel.org>
References: <20240731074544.208411-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731074544.208411-1-animeshagarwal28@gmail.com>


On Wed, 31 Jul 2024 13:15:40 +0530, Animesh Agarwal wrote:
> Convert the NXP LPC3220 timer bindings to yaml format.
> Add missing resets property as it is already being used in dts.
> 
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> ---
>  .../bindings/timer/nxp,lpc3220-timer.txt      | 26 ---------
>  .../bindings/timer/nxp,lpc3220-timer.yaml     | 55 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.yaml
> 

Applied, thanks!


