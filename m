Return-Path: <linux-kernel+bounces-276639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66431949670
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 406ABB2D436
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54C013C8F9;
	Tue,  6 Aug 2024 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwIxAO33"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121F44EB45;
	Tue,  6 Aug 2024 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964064; cv=none; b=CoINpD6x+nds+EbMgcyYkD/yB0PjBN4JitwcLRCpuSujNhnfFnFmwvsWwEkpdNs38o0aiM8za+Oys9Krqd0UfITdGNRvqBflzbEv/0yCcmEc8cI+R1Llu09z0/He+0XYjM4s/kAgE9RXoaU2vsFmWNvC5KZip/xhs1aRwIS9n+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964064; c=relaxed/simple;
	bh=HvEeTOUhv0C5pYu4c2PjUH50AMGhSOMbB8EnQ1HMeqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8NFeejxw0TlCNsvxwUTrxYOO95K0PQITifIk4M/NUiOAilTGeEGW/496ivXhXm4VChcNHWPYBKKM55rnqPf6yDOV4F/0HjQHZZ2DuPz1jPzbz/452154wMDjN2dTFlMkyI+MnYXzdXonZQ3kY6bReMStrQ5ljp/y7orz3MsqKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwIxAO33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63975C32786;
	Tue,  6 Aug 2024 17:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722964063;
	bh=HvEeTOUhv0C5pYu4c2PjUH50AMGhSOMbB8EnQ1HMeqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CwIxAO33u0yFzM+dF0iUSmlKMQsZXTwp8VI7ArfEHq0VvmnDx6cYZLVP1UxWLUfWw
	 GF/uA5Wcsds4bRYB1J98jF2OlYsy1vLLnSZwo0+uUFj5DbOsxC4UbIZ5zDYOsATlGP
	 uLcn7/1lIZ1ef5eTnSzqbAGyf9dTIaX/m0Z40gJRHLURctanhzWe+IBC1oFwnVcsNK
	 M7AXV/D9ruxMGaRGoCrW3IW9MgVQqiophBMn+rxsBN8L0xgm/yY7AUHqMtrzgG4Z9o
	 ac0deMWGdNHxZ+hn9HJgD9wQyc5excsl/0T/9TVWAb+H7IQz5KU90IpSo2oEp9w/f1
	 70sCB3rJtPuTw==
Date: Tue, 6 Aug 2024 11:07:42 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-phy@lists.infradead.org, linux-riscv@lists.infradead.org,
	Minda Chen <minda.chen@starfivetech.com>,
	Vinod Koul <vkoul@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: phy: jh7110-usb-phy: Add sys-syscon
 property
Message-ID: <172296406163.1706072.1585378061823817206.robh@kernel.org>
References: <cover.1722457123.git.jan.kiszka@siemens.com>
 <ebcfe039b13097e53b3721f56a45d99807f2925b.1722457123.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebcfe039b13097e53b3721f56a45d99807f2925b.1722457123.git.jan.kiszka@siemens.com>


On Wed, 31 Jul 2024 22:18:41 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Analogously to the PCI PHY, access to sys_syscon is needed to connect
> the USB PHY to its controller.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> ---
>  .../bindings/phy/starfive,jh7110-usb-phy.yaml         | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


