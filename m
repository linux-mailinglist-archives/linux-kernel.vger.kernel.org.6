Return-Path: <linux-kernel+bounces-217313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C6E90AE35
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4CAC1C20A08
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E87197A61;
	Mon, 17 Jun 2024 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/YnGQSe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3A92F32;
	Mon, 17 Jun 2024 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718628667; cv=none; b=F6UVmuiGrQ1xaW4M7qQx8TlVWCSWgNITAQd4ix5FmtxBJ4VaQOImiiCiURsN3DIvRDx1KpMpD0X8R2gQNtV7zKfnGBJbsPjUrq6geFM30ShvJtpby3zZ7CeedX1AjqBSGHOn1UIfIvV5MfhY+arC+sD3vmzhZ+Wh7ZG1L1U7GwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718628667; c=relaxed/simple;
	bh=uLNOOct/+IDNA5BEiQNsoUwBaJeMoPsnxyuJLLu8iuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUue5ED9SCsaVbwnf1v/pofpYQS8sCF2jaj2BwtaEJazrptjIyUkbs3plZQF7rA6PSKd5vgW7UZlwQEFd4UXuwOePjWCDY09i5XuX1qZlx7SljO7M9MN30mdaqG7R+qehLF2HkMU2zOPLMHTlLRdW1fk20s2BSwOKz4hf8rrPRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/YnGQSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9898C2BD10;
	Mon, 17 Jun 2024 12:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718628666;
	bh=uLNOOct/+IDNA5BEiQNsoUwBaJeMoPsnxyuJLLu8iuY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G/YnGQSeM5SL8J3KK4PfckXwL8GaEM+JhFRwxBls7PqBIMjbZGvc3u0yOJQXBGFnI
	 5ISvQ7tf14zCbnFtqEpTJVwMDGzBIPF7q1c0pl5rJZwVE80Ve1KeFB3YiW8Z8J6vWJ
	 d9qYSTEdu/I+PdiZPFL9RuNfUfY2dcrXGwnBPir/ECqQvH+pfvTEoRTtFdqSFHZLGr
	 ux2dGx7BatrVn35n+uzVgp5Ybfi/6QCVvrNENs8As1zz3AVhIUapMpXAXmQFjBD2AI
	 dkK4lGGMlSEcdvZdPjeIhAdnKNY4KDA/OLwP9djmCFdQ4SRQZGwLiRWwvxNsU7d8KX
	 Jk+GW+jvbG2cQ==
Message-ID: <5c244e93-da7f-4c0c-8644-7ddee5e6de72@kernel.org>
Date: Mon, 17 Jun 2024 15:51:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] arm64: dts: ti: k3-am62p-j722s: Move SoC-specific
 node properties
To: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, vigneshr@ti.com,
 afd@ti.com, kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, danishanwar@ti.com,
 srk@ti.com
References: <20240615081600.3602462-1-s-vadapalli@ti.com>
 <20240615081600.3602462-9-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240615081600.3602462-9-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/06/2024 11:16, Siddharth Vadapalli wrote:
> Certain device-tree node properties of shared device-tree nodes are
> different between the AM62P and J722S SoCs. To avoid overriding the
> properties and to avoid redefining the nodes in the k3-{soc}-main.dtsi
> having such SoC specific properties, move the properties to the SoC
> specific k3-{soc}-main.dtsi files.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Acked-by: Roger Quadros <rogerq@kernel.org>

