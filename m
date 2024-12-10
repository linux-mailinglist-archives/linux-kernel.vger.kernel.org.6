Return-Path: <linux-kernel+bounces-439315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3169EAD8B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B70285A92
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9513823DEB5;
	Tue, 10 Dec 2024 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="cZKSv3ld"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB723DE96;
	Tue, 10 Dec 2024 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733825090; cv=none; b=DgLmDWRgz6iKzTN9u36QG21er0Do6lH5LWJ87PlGtpeUNG45Y5/QfN9F/l0m5MwsOmLRjkxjjsnpG9G8fMr5IbloBhru1TzZVNq38oUW1/P3dsV3J6Et/uQCf8fatkpzeg/vRBr9wU0xl1h1U/CYZcdZqNfS5zyuZvgJ2JPSY5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733825090; c=relaxed/simple;
	bh=1PNJmzZ2WAVkuKjY9BRcQ8kJoyGcegpzX4I1aJ/V/TQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Y/+PvgceX4uI8+3OKKxZvlr34AS85l6TJrTYCaRxlINyrWa3L0ZhSelFSw61KGT397B0ZJ/dHFXXO/T0JgWIxxJX7VbT9AsHKkoIABQORBLOsre0G0tMcjvK9mdeR9j5tQpKH+psn7JdKuJS6KuVQJ6GU4bHza6rJzgTVkNQtC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=cZKSv3ld; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1733825085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1I7wfU9DCOpusJPrwzxJlCH5FeLkZRrVEv4XdJSr+ME=;
	b=cZKSv3ldr6gGegwxMIz1JjnH9exKl+mMNrJ4RQH1roYVzEC9pXfABLJzcSgtzuVa0JSSF8
	c1iw/TrS9tI7hhFaCOFCh/IhydCmy30ki5QEnHhOVVp6Eoca+TWZYRyiStMK2NUXw9Ezrd
	2sflyZrMlYoTLKjNvZgSOtIXYuLbZx9vJKpF72u3heuMHd/kau7Uuee9VMrjIM6Ol+i90W
	PaBdIAm/al7Shz38CJtWFzuzk6M0Tl9R+bvlYQNsuMNI/ijHJEzZZ5E5mxIJJIxcCNHfQP
	p/WNEjV1I8VNdHKS61vkbwh70p6PNYxvURbKsgPgJiBMRZENNXI/YypoAEju1w==
Date: Tue, 10 Dec 2024 11:04:45 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Peter Geis <pgwipeout@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Alex Bee <knaerzche@gmail.com>, Conor
 Dooley <conor+dt@kernel.org>, Diederik de Haas <didi.debian@cknow.org>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Liang Chen <cl@rock-chips.com>, Rob Herring
 <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, shironeko <shironeko@tesaguri.club>
Subject: Re: [PATCH 4/6] arm64: dts: rockchip: add hevc power domain clock to
 rk3328
In-Reply-To: <20241210013010.81257-5-pgwipeout@gmail.com>
References: <20241210013010.81257-1-pgwipeout@gmail.com>
 <20241210013010.81257-5-pgwipeout@gmail.com>
Message-ID: <e32fa593abfa6d08202b4f929e0b4bdb@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Peter,

On 2024-12-10 02:30, Peter Geis wrote:
> There is a race condition at startup between disabling power domains 
> not
> used and disabling clocks not used on the rk3328. When the clocks are
> disabled first, the hevc power domain fails to shut off leading to a
> splat of failures. Add the hevc core clock to the rk3328 power domain
> node to prevent this condition.
> 
> rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 3-.... 
> }
> 1087 jiffies s: 89 root: 0x8/.
> rcu: blocking rcu_node structures (internal RCU debug):
> Sending NMI from CPU 0 to CPUs 3:
> NMI backtrace for cpu 3
> CPU: 3 UID: 0 PID: 86 Comm: kworker/3:3 Not tainted 6.12.0-rc5+ #53
> Hardware name: Firefly ROC-RK3328-CC (DT)
> Workqueue: pm genpd_power_off_work_fn
> pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : regmap_unlock_spinlock+0x18/0x30
> lr : regmap_read+0x60/0x88
> sp : ffff800081123c00
> x29: ffff800081123c00 x28: ffff2fa4c62cad80 x27: 0000000000000000
> x26: ffffd74e6e660eb8 x25: ffff2fa4c62cae00 x24: 0000000000000040
> x23: ffffd74e6d2f3ab8 x22: 0000000000000001 x21: ffff800081123c74
> x20: 0000000000000000 x19: ffff2fa4c0412000 x18: 0000000000000000
> x17: 77202c31203d2065 x16: 6c6469203a72656c x15: 6c6f72746e6f632d
> x14: 7265776f703a6e6f x13: 2063766568206e69 x12: 616d6f64202c3431
> x11: 347830206f742030 x10: 3430303034783020 x9 : ffffd74e6c7369e0
> x8 : 3030316666206e69 x7 : 205d383738353733 x6 : 332e31202020205b
> x5 : ffffd74e6c73fc88 x4 : ffffd74e6c73fcd4 x3 : ffffd74e6c740b40
> x2 : ffff800080015484 x1 : 0000000000000000 x0 : ffff2fa4c0412000
> Call trace:
> regmap_unlock_spinlock+0x18/0x30
> rockchip_pmu_set_idle_request+0xac/0x2c0
> rockchip_pd_power+0x144/0x5f8
> rockchip_pd_power_off+0x1c/0x30
> _genpd_power_off+0x9c/0x180
> genpd_power_off.part.0.isra.0+0x130/0x2a8
> genpd_power_off_work_fn+0x6c/0x98
> process_one_work+0x170/0x3f0
> worker_thread+0x290/0x4a8
> kthread+0xec/0xf8
> ret_from_fork+0x10/0x20
> rockchip-pm-domain ff100000.syscon:power-controller: failed to get ack 
> on
> domain 'hevc', val=0x88220
> 
> Fixes: 52e02d377a72 ("arm64: dts: rockchip: add core dtsi file for 
> RK3328 SoCs")
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>

While I was unable to formally verify this clock assignment,
i.e. by using the RK3328 TRM or the downstream kernel source
from Rockchip, it makes perfect sense to me.  Thanks for the
patch, and please feel free to include:

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> 
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index 0597de415fe0..7d992c3c01ce 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -333,6 +333,7 @@ power: power-controller {
> 
>  			power-domain@RK3328_PD_HEVC {
>  				reg = <RK3328_PD_HEVC>;
> +				clocks = <&cru SCLK_VENC_CORE>;
>  				#power-domain-cells = <0>;
>  			};
>  			power-domain@RK3328_PD_VIDEO {

