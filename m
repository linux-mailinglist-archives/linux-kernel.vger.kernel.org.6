Return-Path: <linux-kernel+bounces-203789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2E48FE082
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E9A4B24A87
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298BE13C695;
	Thu,  6 Jun 2024 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBkzxLV4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C84D13C3F9;
	Thu,  6 Jun 2024 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661088; cv=none; b=qYIAUAFNAicXkHRSFFGADNmMbDd23a1ZANf1Y9AMuGqcC5U+GDX5iOig3aonA9iaDN8ObAYNdTgB3Om9mNHltXSosVIC2JxlSawCpNnjO7BbSR8HSFv9tylXanK5MnCh/knm3sx3U+mKELfSXPPnZQV5f3GwdjlzuGepjmdq1IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661088; c=relaxed/simple;
	bh=QJGJeLqdWFmZAWK47D0o+JKPUpmNxNRDGmQ0IUTw9kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqRiINB97VHypHiETng/d6KTZIerckUZZVncdvw4kbk79joqMaMJFaysAPq7P77Wr5OHIOm4JMVJd91gvc/eZZ+MO5/VcM9piZdCmHMzgEmtwBwk5z8SIC7CqZNbTlk9UJyeazmn5yRFWpoUq2gtoJx/zcTbsLqxDDct/nrxI7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBkzxLV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9880CC4AF14;
	Thu,  6 Jun 2024 08:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717661088;
	bh=QJGJeLqdWFmZAWK47D0o+JKPUpmNxNRDGmQ0IUTw9kk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oBkzxLV4N923RcrMCN9LCj9HTNYE/BC9N91wPN6vi/w+08FtMijLdBoO8MljumoTT
	 ycGEzou6DullTvc3Imn7iLjRJBd8pVTYCKHicLZPOCdeqtB0B+5+GBlXT7uHtEvoWA
	 AQXqjCn3tSq5mxmPaXyhosD4QOgCHtOHyZuh5TvsWmwMwjnpLWEwksTZR4we1sqvow
	 qcyVmDr3OqgjSSMTSIy5C8Yh/HA8zKcA6ZUf20lh32xwEWoTYh3SeZyhtf+A8ODYlg
	 o4ZZYzZUIDNFYMeKGTXnfrjaeW2Xu8jOxzKinuHjz71VOJqEO+uz+Qsf5oIjfa2vCp
	 fw+4uUvPjy/vA==
Message-ID: <bbe37ed0-f29e-42ac-868a-4cc10440b7ab@kernel.org>
Date: Thu, 6 Jun 2024 11:04:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] arm64: dts: ti: k3-j722s-main: Add SERDES and PCIe
 support
To: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, vigneshr@ti.com,
 afd@ti.com, kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, danishanwar@ti.com,
 srk@ti.com
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
 <20240604085252.3686037-7-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240604085252.3686037-7-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/06/2024 11:52, Siddharth Vadapalli wrote:
> J722S SoC has two instances of SERDES namely SERDES0 and SERDES1 and one
> instance of PCIe namely PCIe0. Both SERDES0 and SERDES1 are single lane
> SERDES. The PCIe0 instance of PCIe is a Gen3 single lane PCIe controller.
> 
> Since SERDES and PCIe are not present on AM62P SoC, add the device-tree
> nodes corresponding to them in the J722S SoC specific "k3-j722s-main.dtsi"
> file.
> 
> Co-developed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Acked-by: Roger Quadros <rogerq@kernel.org>

