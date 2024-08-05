Return-Path: <linux-kernel+bounces-274766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3CC947C6E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518C5286284
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C8313A3F0;
	Mon,  5 Aug 2024 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWz4XYWF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D8B3F9D2;
	Mon,  5 Aug 2024 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866598; cv=none; b=saHEKBwxQjhH17HWwPpELSuLCDclfYnKw1m/sCIKMjQkMfUobsqA1GSju2uQnTfiIBGo8ntATZSpdAhvlna6Y4g0RQ6U6UPv2m2mfNK6jDFmuh8tPH1T9aSJ6LrtMwRp+XrbPGofJl18FULkdnh1u4nERgMQOkFsCe6rkstll4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866598; c=relaxed/simple;
	bh=XWE4Ujd4LxMs1wfEcUWg4L8EicQJ4/0b/Ibqs6hpNrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTD+KYDfKHj+lZ/jPaeTsA/mL4qFe/AMnGoSAiN+1cM/fq4IecLV+B5WUcaUS2JWV0X5VRn+c/4mBkLhQtUEe2V+HEy3YQW1ZysuPIYGm+1iD1Qc3043sxTc+kCXJUo9BOrmuYksx8WzMf7XXSzkuTuWPCX1rVO+DiEuS8BR6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWz4XYWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01C1C4AF0B;
	Mon,  5 Aug 2024 14:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722866597;
	bh=XWE4Ujd4LxMs1wfEcUWg4L8EicQJ4/0b/Ibqs6hpNrk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oWz4XYWFmmx2ZZbYjcqfNRxMFREGcezipXPzd8I09Qao+Cc+w0lipliRWPDnXJhCB
	 UeTR4Nx6KZ+1pyKfJsrawrwr0/ms3UGDNBDnIIriZOeUDO8ivbDn177NsFdhdFmHgr
	 fZNnTPiUZRIh/mWJizHS264cfCDVMc6u/LGkwrkIDHpwUXJitGraBqZ4i8AaHyxnET
	 KwdguKazyXhoIO12Mj48EFmQOohsLisCyqEqnnAlecUCpzBhbNu/z1wBHe2yKVOoGO
	 bYZkB9BHZjjs4y/RbpOLSb5geDaDzhr+X9uEujxZ1+6HwznkFdIDe/1Jq6/SRBp+PZ
	 BLyAPVk0TpaNw==
Message-ID: <3ae0e4d4-32c5-4fa4-a384-62ad8f42cf8d@kernel.org>
Date: Mon, 5 Aug 2024 17:03:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] arm64: dts: ti: k3-am64: add USB fallback
 compatible to J721E
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Chen <peter.chen@kernel.org>,
 Pawel Laszczak <pawell@cadence.com>, Mathias Nyman
 <mathias.nyman@intel.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Kevin Hilman <khilman@kernel.org>,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
 <20240726-s2r-cdns-v5-12-8664bfb032ac@bootlin.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240726-s2r-cdns-v5-12-8664bfb032ac@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/07/2024 21:18, Théo Lebrun wrote:
> USB on AM64 is the same peripheral as on J721E. It has a specific
> compatible for potential integration details. Express this
> relationship, matching what the dt-bindings indicate.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

