Return-Path: <linux-kernel+bounces-214669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C5E908802
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174AC1C2241B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1921193079;
	Fri, 14 Jun 2024 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPkGWgHw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDB0192B7D;
	Fri, 14 Jun 2024 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358379; cv=none; b=U3Kc8Mt4LXpnMtsw7VanlMej6eE3d9hUiwFpKBC5RJB44BjHkuZPkfE2SyKDr89VOtyS4w4IJsY4kqCewDE3lAO1K9cPhrWUwJmQAVqNej82Z+JJcmfo+AyOnUyH+QxIQdR0BMEgXrKt7cNhytj2P3mC8pGm8qU0yYClbBH0+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358379; c=relaxed/simple;
	bh=7UTkr31pXhRXctRce1Xs8xhj9mBrgvaGr/Yl6EMdp1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7tCUOUocl7kTV9whHxz6OKvHKYVwE50vC7lXm01NMcAXi2IPwmgsoDG1bbOuay0QsGLM8PjgheOFQ3ATPqJdwGpUjILJZpBeVEbUSNoRkvu5e/fCbKLjDjVR4q09JXdxw8gu/0dwQu2BGsDZ4eQmvDt/5ThiWgHSUB3yt8g9fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPkGWgHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5E1C2BD10;
	Fri, 14 Jun 2024 09:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718358379;
	bh=7UTkr31pXhRXctRce1Xs8xhj9mBrgvaGr/Yl6EMdp1U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RPkGWgHwToGmGm2ew/2XQy1vMw9m3W90TVYXrVVPD4mi1ClcA0gJKrBRmP8mb6r1A
	 gCZNGe/tINaOE2u1FkvZV9i9mQT4TTyxQ7FC0+s/YRyE4Y7sp8GkYwviD9e5cjvkxB
	 nYi8gOD0WascSoa/5qY5XGFodBRTbo5nqXdL4G1tMivh5+SsF3ZNx/oB8R4b2QpECN
	 kW21unt//qiP+4qYzQTK8RK74xnzwYsmj8u07WeQ7CqI1O13yMEEtFl412q+XVFZEX
	 trtThOS0tJ3VPsY9pZmBzdRhjg+lzjy+AmpKYfgbjGixaWK6d/IQ5Ac7mhG0C9OWet
	 gjEThTI2stgZQ==
Message-ID: <10584a9d-7630-4d14-9361-203713990686@kernel.org>
Date: Fri, 14 Jun 2024 12:46:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/8] arm64: dts: ti: k3-j722s: Switch to
 k3-am62p-j722s-common-{}.dtsi includes
To: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, vigneshr@ti.com,
 afd@ti.com, kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, danishanwar@ti.com,
 srk@ti.com
References: <20240612132409.2477888-1-s-vadapalli@ti.com>
 <20240612132409.2477888-5-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240612132409.2477888-5-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/06/2024 16:24, Siddharth Vadapalli wrote:
> Update "k3-j722s.dtsi" to include "k3-am62p-j722s-common-{}".dtsi files in
> order to reuse the nodes shared with AM62P. Also include the J722S specific
> "k3-j722s-main.dtsi".
> 
> Since the J7 family of SoCs has the k3-{soc}.dtsi file organized as:
> k3-{soc}.dtsi = CPU + Cache + CBASS-Ranges + "Peripheral-Includes"
> switch the "k3-j722s.dtsi" file to the same convention.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Acked-by: Roger Quadros <rogerq@kernel.org>

