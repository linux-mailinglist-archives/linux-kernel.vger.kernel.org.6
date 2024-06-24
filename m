Return-Path: <linux-kernel+bounces-227903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C66B9157EF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FFC1C20A33
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3029F1A071A;
	Mon, 24 Jun 2024 20:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAwocCHD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E319137748;
	Mon, 24 Jun 2024 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260701; cv=none; b=qdhsHvoqoT84zsHulbG62oqxHcTCMDskc8loYZPNGGnCSM3Ikr+3JnwGGycKwj0RqDADd/BOeXDkm/If7lWuaKRhZsaahW5vFOF+xOiu8w2BpGaJ0eCcK3TXWKoxAV/REmSq0i1Yoccq1NxegPayNFwSZzWc+OPZOLa8HumeXpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260701; c=relaxed/simple;
	bh=1LlVpG91dCauwKR+1U2omHxHfo85V5EN8OuH9YnYOUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bj8Kodh8yLbGnlFFr0X6xB6Ngosgc6o4UIqK1Njo/q0gM2Mt4cIvvOxQRNVfC8PIUHeYEk6mtkhg9saurT8lBoHhJmaLLKGPewKTTGaYHFuQoSt36TZg6dqw2RtLxU5Td1W+3a59qlgQEQSzcnI4/w88DFVvJwfRFZZZ5aDZVcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAwocCHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F59C32781;
	Mon, 24 Jun 2024 20:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719260700;
	bh=1LlVpG91dCauwKR+1U2omHxHfo85V5EN8OuH9YnYOUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UAwocCHDYAJ4QE5ItFkJ0saC3DnMWCURC3KjDEwDoOi7noHtcUOU9KpikCNa5R/9G
	 2/eIaULQzI+skNPUBpsgxeegX0/kVJLYkW/FjembKY0eu3eaDqkJ/8O7mTsIMar1UD
	 4HbJyeyTcFtpb3iqGqlpGc+f9WdAmd0f+DUDu0MDdIUpcP04yeg3FvGuPBg52gK7x3
	 6zOiTKT7SABgUO/EQkmI9uKj9kK2CR/y5r1Gor8yegifYKc4bReTOuOf7yhi7SrgKV
	 F5e4wTvoMKsy6AZka1GVLb1foOjyn8m5OypAgbdFZGtTAeOuI2Q2zTnlREesErJC38
	 mOWzu1QrOo1tg==
Date: Mon, 24 Jun 2024 14:24:59 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org, kanakshilledar111@protonmail.com,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [RESEND v4 2/2] dt-bindings: riscv: cpus: add ref to
 interrupt-controller
Message-ID: <171926069663.349368.14347809571943198470.robh@kernel.org>
References: <20240615021507.122035-1-kanakshilledar@gmail.com>
 <20240615021507.122035-3-kanakshilledar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240615021507.122035-3-kanakshilledar@gmail.com>


On Sat, 15 Jun 2024 07:45:04 +0530, Kanak Shilledar wrote:
> removed the redundant properties for interrupt-controller
> and provide reference to the riscv,cpu-intc.yaml which defines
> the interrupt-controller. making the properties for riscv
> interrupt-controller at a central place.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> ---
> Changes in v4:
> - Change DCO email to @gmail.com
> Changes in v3:
> - No change.
> - Rolling out as RESEND.
> Changes in v2:
> - Fix warning of `type` is a required property during `make
> dt_bindings_check`.
> ---
>  .../devicetree/bindings/riscv/cpus.yaml       | 21 +------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)
> 

Applied, thanks!


