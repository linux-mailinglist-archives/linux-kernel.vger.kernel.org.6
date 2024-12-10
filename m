Return-Path: <linux-kernel+bounces-439914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3886C9EB5E9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16982167A95
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0174B2309B7;
	Tue, 10 Dec 2024 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a89O4Bfm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF9319D06E;
	Tue, 10 Dec 2024 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847393; cv=none; b=lszwN5V1qCAC7z1zYGzfbY+u4LmwrGAEh84RRUMIgIURaFu0NVDO8HcJmNgnyF6e968ofT/J2u6krkdJLJccbvqfUPvLpyB6CU96jlsd3Gt7ZiDXuey+yQDs1iHo/iCy3OI0KBZNV2gSq7ke5KUZxBGsn84tqXVkVQ4sad6KoxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847393; c=relaxed/simple;
	bh=rzsJ9NMMTP/m0KBPr+ghsEHE/q4mLK8kQfUUsuyDk1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxrquiZ9pYLyWesbRSJwjeCLh4ngZZyuhbr/aI4HmvLFDcIwRiT9P9CFfWbOmGt6xCF6Tr2V4inWyfMeCiTzCcgMpgR83hG9n9B2qHF/I3a2QKBEQgoWlWQQEiUw3XDNMwzcBnHESK+Q0fQd8Mf7Z026QdWmtzPm7KufRQX2rQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a89O4Bfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B37CC4CEDE;
	Tue, 10 Dec 2024 16:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733847392;
	bh=rzsJ9NMMTP/m0KBPr+ghsEHE/q4mLK8kQfUUsuyDk1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a89O4BfmDzVbneHeA9lJ7ce0/9RV85QCJfEd9zoaXsAcOijiRFeiHlJoes6ShV2AW
	 4zEJU/fu+MrZrtGJ50pWMZTsqryXBDjKBReV3iabg74VpRSU2a+NWR5lpLlSZStJUF
	 Vi2bbZwxGb8b+HyuC/XJd5Ap9MSvmd7mDiMEEq/cKbSFP2roURj3UIewMAE4fLYuDt
	 92WB2frvTdYyoSgQr0ZLtSzA8i+QH0XQU7NfxPYsN8prCmVT5fyWu1Zo+k0B2wfAtz
	 WFHqBC8b+CkbWa2YfKZt9ltUAirwCq4ezeJWkjdcg5lcwiZX2CUec7nkscGVdvq0Js
	 ojycG3hVQJJFw==
Date: Tue, 10 Dec 2024 11:16:31 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Troy Hanson <quic_thanson@quicinc.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	ogabbay@kernel.org, corbet@lwn.net, linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.12 033/107] accel/qaic: Add AIC080 support
Message-ID: <Z1hpX_BduAF4b54s@sashalap>
References: <20241124133301.3341829-1-sashal@kernel.org>
 <20241124133301.3341829-33-sashal@kernel.org>
 <51afee37-2c90-d31a-978c-5681dccd5ccb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <51afee37-2c90-d31a-978c-5681dccd5ccb@quicinc.com>

On Sun, Nov 24, 2024 at 12:07:20PM -0700, Jeffrey Hugo wrote:
>On 11/24/2024 6:28 AM, Sasha Levin wrote:
>>From: Jeffrey Hugo <quic_jhugo@quicinc.com>
>>
>>[ Upstream commit b8128f7815ff135f0333c1b46dcdf1543c41b860 ]
>>
>>Add basic support for the new AIC080 product. The PCIe Device ID is
>>0xa080. AIC080 is a lower cost, lower performance SKU variant of AIC100.
>> From the qaic perspective, it is the same as AIC100.
>>
>>Reviewed-by: Troy Hanson <quic_thanson@quicinc.com>
>>Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>>Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
>>Link: https://patchwork.freedesktop.org/patch/msgid/20241004195209.3910996-1-quic_jhugo@quicinc.com
>>Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Sasha, it feels like autosel was a bit aggressive here.  This is an 
>enablement patch for new hardware, and not a bug fix.  Therefore, it 
>does not appear to be stable material to me.
>
>Am I missing something?

Yup, we also take patches that enable new hardware by adding PCI/USB/etc
IDs as well as quirks.

-- 
Thanks,
Sasha

