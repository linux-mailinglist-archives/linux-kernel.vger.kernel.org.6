Return-Path: <linux-kernel+bounces-449438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0B79F4F12
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A947F1894F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2741F7074;
	Tue, 17 Dec 2024 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+pACsDb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F31F666B;
	Tue, 17 Dec 2024 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448294; cv=none; b=UdbYrAfgwqd7M7sbBYXTSTSji68l5JnHopuqhQuUDHpWAfQ4WWlgu7hDFzpRzK3qZTwhAUgr8NmOofIpEzty7RU9/cij71mnzXoSzUTt5BgjiHlqAMZYrFGU/CiwFRgHFKaCMDAu5WcM/5r1FUDcbDQOoq4Y5k/84k02a5mLXqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448294; c=relaxed/simple;
	bh=n37HzBm18BtfmluuyWiYddzhbeZWwmeGcfBuacYm1Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPWEpu2gxeLc32qrRicwvjl0uwHpnOvIhXCoTYrl/kOV7gV2sDcE+GY0VcZMuws1yI7kwAQFVAPyAssBUFULWsCEVO1kz+MaMFS6tSgmJbq4YhQuKZFUPFbFLZcC3qPpnkOUgJot+63WqO5fo0An6j+g19WlehyVutWuIAeuuwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+pACsDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A862C4CED3;
	Tue, 17 Dec 2024 15:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448293;
	bh=n37HzBm18BtfmluuyWiYddzhbeZWwmeGcfBuacYm1Ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S+pACsDbzrfQE5Qj4taP298Q0TAiuff9YxSqXAmNa/VkGDbZKMHEsvr606nFSDMZg
	 CQ2sl0xZQ+h3xkqKxxys9IFszCjNW+Cd3krCQeiIL5LaPZeWD6RyCPMjv9FiH0gEFP
	 3ez8oXhKZqtfbXNeZaUFCv5OedZZ70cSMPtzAfc9Za5pixuIsBzdcUD92xaDTFzm1g
	 p88qlBR/Wmrf/q6Bj2NUHb3FUVzmTXIRSJ4V7FjKbk6BeYvpVLdQSM5D88gMIu4exw
	 A5qpXdtBZ4iFLQXg13LfSQ5hlHbU1IPa7Hn6UzKptXZgtOcVLBtAjIOrdvLwf8nZho
	 7ePMaE4fMbMDg==
Date: Tue, 17 Dec 2024 09:11:32 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Huang Borong <huangborong@bosc.ac.cn>
Cc: tglx@linutronix.de, trivial@kernel.org, krzk+dt@kernel.org,
	aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
	anup@brainfault.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, conor+dt@kernel.org,
	palmer@dabbelt.com, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: update imsic reg
 address to 0x24000000 in Example 1
Message-ID: <173444829149.1744130.11707403858440316768.robh@kernel.org>
References: <20241213090924.181249-1-huangborong@bosc.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213090924.181249-1-huangborong@bosc.ac.cn>


On Fri, 13 Dec 2024 17:09:24 +0800, Huang Borong wrote:
> Change the 'reg' property address from 0x28000000 to 0x24000000
> to match the node label interrupt-controller@24000000.
> 
> Signed-off-by: Huang Borong <huangborong@bosc.ac.cn>
> ---
>  .../devicetree/bindings/interrupt-controller/riscv,imsics.yaml  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


