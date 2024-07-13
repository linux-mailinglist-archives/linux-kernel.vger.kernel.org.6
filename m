Return-Path: <linux-kernel+bounces-251542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC51930610
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 16:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AEC51F21B53
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 14:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA5D13B2B2;
	Sat, 13 Jul 2024 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Zc3fc11Y"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A165913959B;
	Sat, 13 Jul 2024 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720882730; cv=none; b=fCYKpzCnkU31CmaezSymUo3JKZHcW6cZ92ALsGsVEK9D04+o5iOLK8hSRAeb8211v+YPLrO0q54jHeRcgqb0D8/7Huh4ZJALPNnoGcK168Os1rpnDY9OhGoHDinfPSx0juAqD+IS366NgdvY03Rc/as0mREZJKPMOg0OrUaXcto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720882730; c=relaxed/simple;
	bh=mr63rGoZ1GXBaeNJdLVlCAIpfqWi8KXWB5eOIKxFenQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cCO/z1Noe0FuTTiy+/gzQq3xArr67J1A4W4G3BbqhFq+p1BdS+0jEBcFh6f8hi41479i6QS9WaJyGlH5bPXnEi31B1kTUM+2dKTR0w5BHCWKDIZ9znjpbXCKvmIsHi0/cC7BIkeYnNVEMD8HMayS+UrAUYdzMjr9e7T+s2Mfu1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Zc3fc11Y; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1720882725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6LUtO9TwGFe+2ljcswYV7qxJzuvjypqub8o20MTOYw=;
	b=Zc3fc11Y8a+YnyF186vXBF7XCWCGlJxWlKlGXUvZ9T9YWW72ioC9R3+NmSqX1Fq1BdPxl8
	BK5icxTbqgTEGqeaisDoNO7nm+hDYJJ7bf9pLhCZvElnRjFjn/DT9RvJUxQfrVLtQbaStQ
	vXAfWzxy+jd/rZW97SKug10FHDClfS1i4cuaGKUgxPi2njzp+QC1cC0ikZfQRcGG0+hUWL
	ElNKsuUzkYSx2WNQ7FzBUrirM7kz3W67RHGCzJlgUKRLb2Z6ojJRlneBgpS8Nv5zb1uRrr
	NAoa9HV5JF3McpQt55/JvzPhc2Joy46750TzSR136hLxeTaeyyGg5yCamiVndw==
Date: Sat, 13 Jul 2024 16:58:45 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Diederik de Haas <didi.debian@cknow.org>, Heiko Stuebner
 <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>, Chen-Yu Tsai
 <wens@csie.org>
Subject: Re: [PATCH v3 1/2] arm64: dts: rockchip: Add sdmmc_ext for RK3328
In-Reply-To: <969642dd-fe5f-4dfd-baac-21e75e30a271@gmail.com>
References: <20240710132830.14710-1-didi.debian@cknow.org>
 <20240710132830.14710-3-didi.debian@cknow.org>
 <72718d8d02c25993c138567c96340792@manjaro.org> <2735059.JVtD0IzA6d@bagend>
 <969642dd-fe5f-4dfd-baac-21e75e30a271@gmail.com>
Message-ID: <529bd79969ced12bbb5a3b1c3d5ba53c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alex,

On 2024-07-13 16:56, Alex Bee wrote:
> Am 13.07.24 um 16:35 schrieb Diederik de Haas:
>> Hi Dragan,
>> 
>> Thanks for the reviews!
>> 
>> On Saturday, 13 July 2024 15:45:12 CEST Dragan Simic wrote:
>>> Looking good to me, cross-referencing the RK3328 TRM and the
>>> downstream RK3328 SoC dtsi checks out.  Though, it will remain inert
>>> in our codebase, because no supported boards use it, but that's fine,
>>> we're still improving the correctness of the RK3328 SoC dtsi.
>> Indeed. But it's hard to argue with technically correct ;-)
> 
> FWIW: (upstream supported) ROC-RK3328-PC has sdio wifi connected to 
> this
> controller.

Oh, it does?  Good to hear, so the additions to the RK3328 SoC dtsi
shouldn't remain inert. :)

