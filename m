Return-Path: <linux-kernel+bounces-307532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B52ED964E9E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72ECD28324A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2F01B8E84;
	Thu, 29 Aug 2024 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/PwZUHC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7D39FC1;
	Thu, 29 Aug 2024 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959071; cv=none; b=QjLitWw9ETVMD2zoOxq9Gpty6orVOqqOBcOTtuY2BM0RWYnoLWGCjg0NI1T1fVpUnL+JakuaISM+LsI2SXF+o8tyuDWEQfjld+4BKkewgo+M6UaDUTscW4JYoOHs0/FWO4CbsfCE4Etk6uE0BFk/k/fUf8MIMYUy55Zf513IKW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959071; c=relaxed/simple;
	bh=D1pwolbhKxBhlHU8BrJEAN68+m9aF26/PtnnDlz1FzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWBoDpHqzUYltJgyZsZGWby21kVNMBHajQqNPwW3bpfSKIHkMhgJK29JhY441oA/yxaKrJer4Rh2svmvO6Hqkr5V6Yb7xuSJ0FKd/+CJM5NKhvbcy1HWrJ0ByEcUCuDIYodLZrvBWy7SxBJH+e6viKyGCJE0dIxb9lfOPAd2MIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/PwZUHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B81C4CEC1;
	Thu, 29 Aug 2024 19:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724959071;
	bh=D1pwolbhKxBhlHU8BrJEAN68+m9aF26/PtnnDlz1FzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H/PwZUHCEMUAZHGSgvtU7b0aljQtchgVHXQjoH/6FhMJvmtFF1JkwCkkc1n6yEdcH
	 xuGotQdmJmUPFfCWM0jDBGeYYr3RKP/upFgT2/aqtEBBjIs1TX130fBjIq9i9Fm2nf
	 AHkB2C0XFDI14E8T/+5XAvWtR/EAVprPgNy+s9m2xw8Cad9mdcJaCiC8R0uQ59KhPs
	 Yx6EZb/ZVOYID8qe4RfFIoVMLSM4HNcAaOId/ggNB3JXS+FLVbvFpgWNR0VUp/9wgb
	 f6yk+dUMFDV8X35A0fbPrPW/ExradjGBxdg2UBPQsGMct+ntBanuYiPXCl9vHL1n/x
	 ljlmhb1ZjExBg==
Message-ID: <c8b99b25-ee82-479a-9fdc-48da5be45d44@kernel.org>
Date: Thu, 29 Aug 2024 21:17:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] usb: typec: Add support for Parade PS8830 Type-C
 Retimer
To: Abel Vesa <abel.vesa@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rajendra Nayak <quic_rjendra@quicinc.com>,
 Sibi Sankar <quic_sibis@quicinc.com>, Johan Hovold <johan@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Trilok Soni <quic_tsoni@quicinc.com>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org
References: <20240829-x1e80100-ps8830-v1-0-bcc4790b1d45@linaro.org>
 <20240829-x1e80100-ps8830-v1-2-bcc4790b1d45@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240829-x1e80100-ps8830-v1-2-bcc4790b1d45@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.08.2024 8:44 PM, Abel Vesa wrote:
> The Parade PS8830 is a Type-C muti-protocol retimer controlled over I2C.
> It provides both altmode and orientation handling.
> 
> Add a driver with support for the following modes:
>  - DP 4lanes
>  - USB3
>  - DP 2lanes + USB3
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

[...]

> +	retimer->supplies[0].supply = "vdd33";
> +	retimer->supplies[1].supply = "vdd18";
> +	retimer->supplies[2].supply = "vdd15";

1.15?

Konrad

