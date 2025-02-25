Return-Path: <linux-kernel+bounces-531366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9766AA43F90
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE8316740E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A072686A1;
	Tue, 25 Feb 2025 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSJeqb1R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669173A1DB;
	Tue, 25 Feb 2025 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740487191; cv=none; b=Z/psk/d5CptWMA7LPiBGnJJ5PbSAyrtp9U7uAHWnFhS+Zu2E+gi+yQqH2mCCB/VNQ6hCSnFl4jCC+Efg2OGYfsSQtGmENQM7LeCUCOZbgv3sEOC1nM9aw/N+GTbGRIiN+I8MV2xP13PVtYnFxH76dnp3v4RQdkqXNn6AoaLOFYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740487191; c=relaxed/simple;
	bh=ysdTSoy5+tQu1v8OXYYLwr1gFllUvzipKpvwf+BiQp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EYQaJerN/e8Zi0sJqAbwJExbp1Ph4mY44dzykdbU5daIRwRCOKo1MK0CzkvgOP81ka7Wkf7jsiE0JLV/TKyq2CMFblCC9tXsMr5Wy7QAQh3hfYmcJhhdlNsA3doK7gwsRcUplh6LbGJ+ypekQAH6RBjnKNtNA1joDlI19fcWTAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSJeqb1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3D3C4CEDD;
	Tue, 25 Feb 2025 12:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740487190;
	bh=ysdTSoy5+tQu1v8OXYYLwr1gFllUvzipKpvwf+BiQp4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=SSJeqb1Ro7U1paI/dFGI4o8yb/mJVt6N2bOYk0ERj/uqMi36Xf8tlqyShWlODGjcA
	 svbKvfG7YSaqdFFlcHpDC8Dgu4Iqiek0jVEyGAr6SKmRPu3SoY+6rBK/0n8hbCuYRU
	 x6rAjp5uwQ2DQAHXRk6gxYt2tfyklHFOUr6MxnCUSshQ3tcFK7bo9Y9HEDerFQTiaW
	 p8Ycj/vycjyBADbjT1esAzFqf3R7nyPMpoU1gNL/I6v7FY7NvsYIVkq+annvYo5E61
	 rO1OlC1Lpat9399d09gIrXdCAh2v2eUdrrUivkN0UUs0LJhZd8Se9sZYeJzND/3uO1
	 p+GA38n/i2ySw==
Message-ID: <80a7c6b5-2a58-4b0f-a856-87b9c3c03a83@kernel.org>
Date: Tue, 25 Feb 2025 06:39:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: socfpga: agilex5: add qspi flash node
To: niravkumar.l.rabara@intel.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, nirav.rabara@altera.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250205101153.1778622-1-niravkumar.l.rabara@intel.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250205101153.1778622-1-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/25 04:11, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Add Micron qspi nor flash node for Intel SoCFPGA Agilex5.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
> 
> changes in v2:
>    * Removed unexpected properties to fix dts build warnings.
> 
> Link to v1:https://lore.kernel.org/all/20250108112834.2880709-1-niravkumar.l.rabara@intel.com/
>   
>   .../boot/dts/intel/socfpga_agilex5_socdk.dts  | 31 +++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
>

Applied!


