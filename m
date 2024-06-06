Return-Path: <linux-kernel+bounces-203791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703468FE086
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E50AAB25672
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB3013C673;
	Thu,  6 Jun 2024 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idYKHJyJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B65DDD2;
	Thu,  6 Jun 2024 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661159; cv=none; b=bFJ2Y01mGA1FbmQfL9ygGD7FrfM7o5EtZCMRd8e9owixintqnLMN0ZGUNCIdue1JfZYWRF1arIKSvT83fUkSlduJO7JsoI0kNmMcn7tyQ8zcm91S24rK85eXo+2AkdobzEpko+xLR6ywZNJpN/vBmJvqUVYEdpc67xsF3AsHdZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661159; c=relaxed/simple;
	bh=gnsWToD3HK8zVkJG7jZHmk7g+FgjMnmbpNeGvYjSrYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGPGqCQGEqUjhamSQjjoutk17zssH6ST68+6IliqaBNtQKzMgazWElap17l46+ivIO1/z1oPUxXo+2Brqxze22PTuLL7duhZTg/Mc7uP7HgsKj/XpwmP2kIJVORNdYNdQOUDD9Cn4E264aKhXJtPmoWjelnhQzmMi5xevPg0A00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idYKHJyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB475C3277B;
	Thu,  6 Jun 2024 08:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717661159;
	bh=gnsWToD3HK8zVkJG7jZHmk7g+FgjMnmbpNeGvYjSrYE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=idYKHJyJaCZbgEH+AFc1ahbdaJTF8iSO0ZjeR3wtum/jA2PdYrtGPk4TVbR9/JBLl
	 rm1JcIMm/6SOHrbwX0BxG0DP+JYcaACXQgc1f+vRDjhIuwHQJlO9T/uetqGi7ejjcW
	 SRYFVqd1FEAQibsjpcbZDzHAQsfpqhjVH4LYKBg5t8aGHosgH4tRQe3orRlgou/f5M
	 OtETUDqWpkGKkmS98aMUlFTIYbod6U7CuVLSrp2oq+ilOdUwSxME/ISbU/JV514LzG
	 vBH1/nxZVYK9nKsDoDQeZ/DWezU9vcF8/uxURdWjgWfdwCF+2QCT6Rze9P8Mm+JFhf
	 SHsByPhRVdzpQ==
Message-ID: <9261c812-f607-4ee0-924c-8380e2f85b12@kernel.org>
Date: Thu, 6 Jun 2024 11:05:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] arm64: dts: ti: k3-j722s: Enable PCIe and USB
 support on J722S-EVM
To: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, vigneshr@ti.com,
 afd@ti.com, kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, danishanwar@ti.com,
 srk@ti.com
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
 <20240604085252.3686037-8-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240604085252.3686037-8-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/06/2024 11:52, Siddharth Vadapalli wrote:
> Enable PCIe0 instance of PCIe in Root Complex mode of operation with Lane 0
> of the SERDES1 instance of SERDES. Also enable USB0 instance of USB to
> interface with the Type-C port via the USB hub, by configuring the pin P05
> of the GPIO expander on the EVM. Enable USB1 instance of USB in SuperSpeed
> mode of operation with Lane 0 of the SERDES0 instance of SERDES.
> 
> Co-developed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Acked-by: Roger Quadros <rogerq@kernel.org>

