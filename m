Return-Path: <linux-kernel+bounces-203786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7598FE079
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1FD28489D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C2913CA97;
	Thu,  6 Jun 2024 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AL7G/EvU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDABF13C3D7;
	Thu,  6 Jun 2024 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660931; cv=none; b=aVRh5NDi4xR2FomAZV0OBesBgEMwAY1UMj1zcc0NdHP/K9Gqzrgo/2mTRwd6l53MCkmXXjTxqYd5xAlCeVYKZmRSGGHKGyq21pNceM/30Ghc+BJRAJjH4aVn0CdJ8tsNPBRmHJLU1H5/E8QQiJ/1BKCODErrtBx3Y7nGd36yG1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660931; c=relaxed/simple;
	bh=93k3PtHJzDAMFhOC0Ooe7U/LJ+vNYXxiHKEaOFbowow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSC5Glpa+0s0Olh4h1Bsnm4HJsAJpYjeidSyYxmafvWiZHUuNxzzp6DDEjBxfXM79H+o04fULvQdfNMyAolvc/MZk4tww+FjByGxCBp3B6GJ0rlpiS4ubTvPytcOS9zMmWB9wXY0tgxHNjlAKBe5fdp/6cfH7+6+r1q+mhIhIGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AL7G/EvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707E5C4AF16;
	Thu,  6 Jun 2024 08:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717660931;
	bh=93k3PtHJzDAMFhOC0Ooe7U/LJ+vNYXxiHKEaOFbowow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AL7G/EvUzsUJoREKsosZxqS52FAXmsIJxMuaH3icliHjre3p0Chi1gRgUht+4l9dS
	 eHc7LAuE6XaKPthpDHxxYG3wqeiTuM5ich7I4Ph8o5SagLLCrM9CmTbh9TslPXkfMj
	 LGQDS+qs2sfRMUeyBssmjjUNq1U/6V44ljsMtUwZPWEdgRzoebLQR2tYJTauiNKnSX
	 3iEkQ/GRnHVd1ZOuYUKoU3lDMBQk2WxENh/ZGr6fzMa9a9yYsX2D5AIlpIKh6aIKpj
	 YOgI/njpslsM/N/hNyY7uz5djUcw/pkuB9BuQ7fqJiqj4o1zImc5ZdwEhcMAAahav1
	 RdCAB45fQZkwQ==
Message-ID: <c671efd1-8554-40cb-ba62-c7e043a8c09b@kernel.org>
Date: Thu, 6 Jun 2024 11:02:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] arm64: dts: ti: k3-j722s: Add main domain
 peripherals specific to J722S
To: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, vigneshr@ti.com,
 afd@ti.com, kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, danishanwar@ti.com,
 srk@ti.com
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
 <20240604085252.3686037-4-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240604085252.3686037-4-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/06/2024 11:52, Siddharth Vadapalli wrote:
> Introduce the "k3-j722s-main.dtsi" file to contain main domain peripherals
> that are specific to J722S SoC and are not shared with AM62P. The USB1
> instance of the USB controller on J722S is different from that on AM62P.
> Thus, add the USB1 node in "k3-j722s-main.dtsi".
> 
> Co-developed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Acked-by: Roger Quadros <rogerq@kernel.org>

