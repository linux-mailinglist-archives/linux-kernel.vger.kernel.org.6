Return-Path: <linux-kernel+bounces-563152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6275AA63792
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 22:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686993ACA07
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 21:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23346199FD0;
	Sun, 16 Mar 2025 21:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="fypAfLWf"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAB01624D2
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 21:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742161936; cv=none; b=GzydfK2QggjYzUivDeBc1yqt/q07+TdDAMOg5XXmmyZC2Q8Od1QFiGIO+5pj83TDY1112qDFvP7p9u51wf1T6Tn1HUn5IzZeTxrczhaqGpElzmt2VfahuVyRNxTGBMzqLQMqPJ6Bj+URUnci/qyxwI1bEiDXeWT5Gzfom6H0/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742161936; c=relaxed/simple;
	bh=YH8lD/rVyrTNyFmZSb4KjflN68yPPe3RTT56NzBjRAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RdeStkZVSzzmT5BFSH3HmjT6/FX7i+nue7G1KfLS5yoNnGCneu9Z/uZ4c9OpTxutE+92b4P5sjYSClpf7fN9+rjIIqHop80dP4RMe0Uo5H92S6niuLKU+rXd326aVm9gr/u1atRz6s5tn3+g7Bd6+labrZKIuz9DvbhF6jw+C7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=fypAfLWf; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1742161933;
 bh=vmHPFcJZ78hwHnl9SxGCphVe0yu9MYFikge7ywKMkGc=;
 b=fypAfLWf/ME8dg5noGXNMp/8Wab4XTl193L0LFrXe1LPedPh+IgZy54rLjN3yg7s19P1/x6e2
 Y9H9b4M1Yd3qdyOeUEYLg/YGkEQEu7XFQQ8HbNs9uRXdL3wW0J9ow5sOOIdxVAL3hchuqFq8rcl
 CsSg5nwukEg/LduqdZIyDLx49ZQR02wZC+XD0Z7x2dtqjNgTcRK1z/ZC+unJyyreCG38URTI004
 m3YEaoaMPptqDQI2n/x5iidSUNwn73+8RrQf56fgDgjDoJ/As0dYzX8dG8GrnE0ZEJgBLJZQL/i
 OGWrnmo6ffHmJ0+dHpNgZ0DQFwAOk6+Nn32mWeVIGEJA==
X-Forward-Email-ID: 67d7480b615b196bfb50e07f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <8c697031-9978-40cd-a1e0-f40552db9107@kwiboo.se>
Date: Sun, 16 Mar 2025 22:52:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] nvmem: rockchip-otp: Add support for rk3568-otp
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
 Finley Xiao <finley.xiao@rock-chips.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20250227110804.2342976-1-kever.yang@rock-chips.com>
 <20250227110804.2342976-2-kever.yang@rock-chips.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250227110804.2342976-2-kever.yang@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kever,

On 2025-02-27 12:08, Kever Yang wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> This adds the necessary data for handling efuse on the rk3568.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/nvmem/rockchip-otp.c | 82 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
> index ebc3f0b24166..a04bce89ecc8 100644
> --- a/drivers/nvmem/rockchip-otp.c
> +++ b/drivers/nvmem/rockchip-otp.c
> @@ -27,6 +27,7 @@
>  #define OTPC_USER_CTRL			0x0100
>  #define OTPC_USER_ADDR			0x0104
>  #define OTPC_USER_ENABLE		0x0108
> +#define OTPC_USER_QP			0x0120
>  #define OTPC_USER_Q			0x0124
>  #define OTPC_INT_STATUS			0x0304
>  #define OTPC_SBPI_CMD0_OFFSET		0x1000
> @@ -53,6 +54,8 @@
>  #define SBPI_ENABLE_MASK		GENMASK(16, 16)
>  
>  #define OTPC_TIMEOUT			10000
> +#define OTPC_TIMEOUT_PROG		100000

This is not used anywhere in this patch, please drop it.

> +#define RK3568_NBYTES			2
>  
>  /* RK3588 Register */
>  #define RK3588_OTPC_AUTO_CTRL		0x04
> @@ -184,6 +187,70 @@ static int px30_otp_read(void *context, unsigned int offset,
>  	return ret;
>  }
>  
> +static int rk3568_otp_read(void *context, unsigned int offset, void *val,
> +			   size_t bytes)
> +{
> +	struct rockchip_otp *otp = context;
> +	unsigned int addr_start, addr_end, addr_offset, addr_len;
> +	unsigned int otp_qp;
> +	u32 out_value;
> +	u8 *buf;
> +	int ret = 0, i = 0;
> +
> +	addr_start = rounddown(offset, RK3568_NBYTES) / RK3568_NBYTES;
> +	addr_end = roundup(offset + bytes, RK3568_NBYTES) / RK3568_NBYTES;
> +	addr_offset = offset % RK3568_NBYTES;
> +	addr_len = addr_end - addr_start;
> +
> +	buf = kzalloc(array3_size(addr_len, RK3568_NBYTES, sizeof(*buf)),
> +		      GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = rockchip_otp_reset(otp);
> +	if (ret) {
> +		dev_err(otp->dev, "failed to reset otp phy\n");
> +		return ret;

This is leaking the kzalloc memory above.

> +	}
> +
> +	ret = rockchip_otp_ecc_enable(otp, true);
> +	if (ret < 0) {
> +		dev_err(otp->dev, "rockchip_otp_ecc_enable err\n");
> +		return ret;

Same here.

> +	}
> +
> +	writel(OTPC_USE_USER | OTPC_USE_USER_MASK, otp->base + OTPC_USER_CTRL);
> +	udelay(5);
> +	while (addr_len--) {
> +		writel(addr_start++ | OTPC_USER_ADDR_MASK,
> +		       otp->base + OTPC_USER_ADDR);
> +		writel(OTPC_USER_FSM_ENABLE | OTPC_USER_FSM_ENABLE_MASK,
> +		       otp->base + OTPC_USER_ENABLE);
> +		ret = rockchip_otp_wait_status(otp, OTPC_INT_STATUS, OTPC_USER_DONE);
> +		if (ret < 0) {
> +			dev_err(otp->dev, "timeout during read setup\n");
> +			goto read_end;
> +		}
> +		otp_qp = readl(otp->base + OTPC_USER_QP);
> +		if (((otp_qp & 0xc0) == 0xc0) || (otp_qp & 0x20)) {
> +			ret = -EIO;
> +			dev_err(otp->dev, "ecc check error during read setup\n");
> +			goto read_end;
> +		}
> +		out_value = readl(otp->base + OTPC_USER_Q);
> +		memcpy(&buf[i], &out_value, RK3568_NBYTES);
> +		i += RK3568_NBYTES;
> +	}
> +
> +	memcpy(val, buf + addr_offset, bytes);
> +
> +read_end:
> +	writel(0x0 | OTPC_USE_USER_MASK, otp->base + OTPC_USER_CTRL);
> +	kfree(buf);
> +
> +	return ret;
> +}

This can be simplified if this is rebased on top of "nvmem: rockchip-otp:
Handle internal word_size in main reg_read op" [1].

[1] https://lore.kernel.org/r/20250316191900.1858944-1-jonas@kwiboo.se

Something like following could be squashed in with this:

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index ea48d51bc2ff..0991a4047bec 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -54,8 +54,6 @@
 #define SBPI_ENABLE_MASK		GENMASK(16, 16)
 
 #define OTPC_TIMEOUT			10000
-#define OTPC_TIMEOUT_PROG		100000
-#define RK3568_NBYTES			2
 
 /* RK3588 Register */
 #define RK3588_OTPC_AUTO_CTRL		0x04
@@ -188,24 +186,12 @@ static int px30_otp_read(void *context, unsigned int offset,
 }
 
 static int rk3568_otp_read(void *context, unsigned int offset, void *val,
-			   size_t bytes)
+			   size_t count)
 {
 	struct rockchip_otp *otp = context;
-	unsigned int addr_start, addr_end, addr_offset, addr_len;
-	unsigned int otp_qp;
-	u32 out_value;
-	u8 *buf;
-	int ret = 0, i = 0;
-
-	addr_start = rounddown(offset, RK3568_NBYTES) / RK3568_NBYTES;
-	addr_end = roundup(offset + bytes, RK3568_NBYTES) / RK3568_NBYTES;
-	addr_offset = offset % RK3568_NBYTES;
-	addr_len = addr_end - addr_start;
-
-	buf = kzalloc(array3_size(addr_len, RK3568_NBYTES, sizeof(*buf)),
-		      GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	u16 *buf = val;
+	u32 otp_qp;
+	int ret;
 
 	ret = rockchip_otp_reset(otp);
 	if (ret) {
@@ -214,39 +200,39 @@ static int rk3568_otp_read(void *context, unsigned int offset, void *val,
 	}
 
 	ret = rockchip_otp_ecc_enable(otp, true);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(otp->dev, "rockchip_otp_ecc_enable err\n");
 		return ret;
 	}
 
 	writel(OTPC_USE_USER | OTPC_USE_USER_MASK, otp->base + OTPC_USER_CTRL);
 	udelay(5);
-	while (addr_len--) {
-		writel(addr_start++ | OTPC_USER_ADDR_MASK,
+
+	while (count--) {
+		writel(offset++ | OTPC_USER_ADDR_MASK,
 		       otp->base + OTPC_USER_ADDR);
 		writel(OTPC_USER_FSM_ENABLE | OTPC_USER_FSM_ENABLE_MASK,
 		       otp->base + OTPC_USER_ENABLE);
-		ret = rockchip_otp_wait_status(otp, OTPC_INT_STATUS, OTPC_USER_DONE);
-		if (ret < 0) {
+
+		ret = rockchip_otp_wait_status(otp, OTPC_INT_STATUS,
+					       OTPC_USER_DONE);
+		if (ret) {
 			dev_err(otp->dev, "timeout during read setup\n");
 			goto read_end;
 		}
+
 		otp_qp = readl(otp->base + OTPC_USER_QP);
 		if (((otp_qp & 0xc0) == 0xc0) || (otp_qp & 0x20)) {
 			ret = -EIO;
 			dev_err(otp->dev, "ecc check error during read setup\n");
 			goto read_end;
 		}
-		out_value = readl(otp->base + OTPC_USER_Q);
-		memcpy(&buf[i], &out_value, RK3568_NBYTES);
-		i += RK3568_NBYTES;
-	}
 
-	memcpy(val, buf + addr_offset, bytes);
+		*buf++ = readl(otp->base + OTPC_USER_Q);
+	}
 
 read_end:
 	writel(0x0 | OTPC_USE_USER_MASK, otp->base + OTPC_USER_CTRL);
-	kfree(buf);
 
 	return ret;
 }

> +
>  static int rk3588_otp_read(void *context, unsigned int offset,
>  			   void *val, size_t bytes)
>  {
> @@ -274,6 +341,17 @@ static const struct rockchip_data px30_data = {
>  	.reg_read = px30_otp_read,
>  };
>  
> +static const char * const rk3568_otp_clocks[] = {
> +	"usr", "sbpi", "apb_pclk", "phy",

Why do we change from using the "otp"-name for the main clock?

I suggest we keep the main clock named "otp" instead of "usr" for
consistency.

> +};
> +
> +static const struct rockchip_data rk3568_data = {
> +	.size = 0x80,

If this is rebased on top of [1] you should also add:

	.word_size = sizeof(u16),

Above suggested changes can also be found in a FIXUP commit at my
linux-rockchip tree of pending RK3528 patches [2].

[2] https://github.com/Kwiboo/linux-rockchip/commits/next-20250314-rk3528/

Regards,
Jonas

> +	.clks = rk3568_otp_clocks,
> +	.num_clks = ARRAY_SIZE(rk3568_otp_clocks),
> +	.reg_read = rk3568_otp_read,
> +};
> +
>  static const char * const rk3588_otp_clocks[] = {
>  	"otp", "apb_pclk", "phy", "arb",
>  };
> @@ -294,6 +372,10 @@ static const struct of_device_id rockchip_otp_match[] = {
>  		.compatible = "rockchip,rk3308-otp",
>  		.data = &px30_data,
>  	},
> +	{
> +		.compatible = "rockchip,rk3568-otp",
> +		.data = &rk3568_data,
> +	},
>  	{
>  		.compatible = "rockchip,rk3588-otp",
>  		.data = &rk3588_data,


