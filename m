Return-Path: <linux-kernel+bounces-203749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891CE8FDFF1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D921C212D4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0FD13BACE;
	Thu,  6 Jun 2024 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYhM7Ojh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8B729CE7;
	Thu,  6 Jun 2024 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717659353; cv=none; b=NK1WhG/FgDELZZKDiQQ87BxZpgLW6nwsWpSZx/NOIPH8fOU+E3vxVQkBsGHGr4iP1k7B5kDVyX6jiytZku++eKTSqleLWEhl3vOby/Jdxg2K14C/2D1Xipx/Ty4s3ck2VijgzgZ0uMT/QQT3xQWtAYLG0yaHD62KZ8e7w3QbWtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717659353; c=relaxed/simple;
	bh=cdg8LAMU/zlMciHFP8eGkXefS7eJ6QcdTtOc/2P2qlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lbw2TSptZ6a+jypBJ7gWg5T/rQCSd1NkdrsX2YGuWJhDVyXpJ5HQkfUfw1HmWQusO5AH8EOvLFj8rJ/HUDtvNI6JGb0K5RZyhsMMQQHWnhSLpSLRcRNAYoefAo9IcSWNxViZwPJNGjYKjyZ2mj+PH3dSCxtULMZQzr2WBIsSEkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYhM7Ojh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D46EC2BD10;
	Thu,  6 Jun 2024 07:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717659352;
	bh=cdg8LAMU/zlMciHFP8eGkXefS7eJ6QcdTtOc/2P2qlM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KYhM7OjhFeyl3Robf/n0a0WdJO6GdgzeVuicl3Z9H9oBQkGs8Tda8xNJ3aDh4ajlm
	 5TuZCUnDPpbq/ZROR7Z+EWfc6UZtlycSTRtXV+fmLlyQwyHykVpMqqL3MWc2uF0Wqz
	 xN9p3ocTm/gYmBffn3w9K0/K7CaDX+Ir5XqLEa5s95epRO7DX8GUuqheiggJQxAmn5
	 NcLg0S49VQGJqwZ0QSTQlWKWEEwYoNCjVuWgqfwq9hyQALU0KBQMsxE0jJ1ofAQ9qw
	 JUgr1XtKzDs8c8coZTWLmgYptWuuZn2tIeSUNyTo4dQwYOz55uO50e2uWN0LzadBMC
	 wuVPI2pLmh/fA==
Message-ID: <d04ed187-1385-40a4-bf97-9e28d542508f@kernel.org>
Date: Thu, 6 Jun 2024 10:35:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] arm64: dts: ti: k3-serdes: Add SERDES0/SERDES1
 lane-muxing macros for J722S
To: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, vigneshr@ti.com,
 afd@ti.com, kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, danishanwar@ti.com,
 srk@ti.com
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
 <20240604085252.3686037-6-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240604085252.3686037-6-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/06/2024 11:52, Siddharth Vadapalli wrote:
> The SERDES0 and SERDES1 instances of SERDES on J722S are single lane
> SERDES which are individually muxed across different peripherals.
> 
> LANE0 of SERDES0 is muxed between USB and CPSW while LANE0 of SERDES1 is
> muxed between PCIe and CPSW.
> 
> Define the lane-muxing macros to be used as the idle state values.
> 
> Co-developed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

