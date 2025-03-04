Return-Path: <linux-kernel+bounces-544174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F14EFA4DE3B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DAF3AC017
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF7D202C32;
	Tue,  4 Mar 2025 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuhCZpCV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CDD1FC7FD;
	Tue,  4 Mar 2025 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092467; cv=none; b=QojOV808+1RuSyDOOx0FumvwBCc/43BhM2J6M1bKtPgbU7sLIPE+3e7JGpP2A7WKT8CLsuF2dJ9IEBX2KvDWKkpS0FDxNAQBL5PMyXj8Q9DSVZTbJqebAsTQEIp81SE37C7WlFvsr3Lf8Qy/oej0xsZisGmvgnxWh4kdPGy8Clk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092467; c=relaxed/simple;
	bh=s41CNZeyxYqiFP0x3AH953mCpbPKMcXkWgAF8ScBLQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OXoJvWCltoDOntVC4FkXcKWo5hjRaXPXnQ0U845L9GeKHcsWj+3ID3w+1YAaoGUedBkcbiaFocSQYjjCRM9Dge4rkKlUbiWgkf0vhVgb5xLQ+EKXZsWNUjqoRB9hi5Im3hUrg5jdikeihsjMSDr1BCPolQONCyGVEcq+chBTg6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuhCZpCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC72C4CEE5;
	Tue,  4 Mar 2025 12:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741092467;
	bh=s41CNZeyxYqiFP0x3AH953mCpbPKMcXkWgAF8ScBLQk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=UuhCZpCV+48Hwj2XBN9aDqgVdGjzmqaNboPLV2rN0vRryFgNZRj8LK8HSPT7guefr
	 ExtRYcA/Z1eI1pRFkRtaNglWGsMD5L28t8nwHmDF0NCAhRL0pS0JN1KodKD9FMBAXx
	 T94GxVYd93us+/ulMAwIpgAFt/+BeCcYkHf5h0+ykShuPFEsXfym+rTkM5tGDxeT8v
	 22HUBkxKEUqYlp7Y2W3lPHrzAd9bHGXDxNaAhtZw5JiDRptcCWOmFiv+1HmQ0j9AfG
	 7wPc9vO5w3uG7BdlnXfjdvKpQftTbcZBDzEVQmtnM653AkHbNTjUmM5Qk5++ts1HsI
	 dhxMVbiKte0XQ==
Message-ID: <f2c1a48e-74e3-4f8c-af3c-aafbfc40fd3f@kernel.org>
Date: Tue, 4 Mar 2025 06:47:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: intel: socfpga_agilex: add frequencies to
 internal oscillators
To: Matthew Gerlach <matthew.gerlach@altera.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250226185451.11748-1-matthew.gerlach@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250226185451.11748-1-matthew.gerlach@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/25 12:54, Matthew Gerlach wrote:
> Add clock-frequency property to the internal oscillators, cb_intosc_ls_clk
> and cb_intosc_hs_div2_clk.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
>   arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> index 1235ba5a9865..bcd12f82636f 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> @@ -114,11 +114,13 @@ clocks {
>   		cb_intosc_hs_div2_clk: cb-intosc-hs-div2-clk {
>   			#clock-cells = <0>;
>   			compatible = "fixed-clock";
> +			clock-frequency = <200000000>;
>   		};
>   
>   		cb_intosc_ls_clk: cb-intosc-ls-clk {
>   			#clock-cells = <0>;
>   			compatible = "fixed-clock";
> +			clock-frequency = <400000000>;
>   		};
>   
>   		f2s_free_clk: f2s-free-clk {

Applied!

Thanks,
Dinh

