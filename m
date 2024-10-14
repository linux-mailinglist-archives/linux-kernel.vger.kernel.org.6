Return-Path: <linux-kernel+bounces-363750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA8F99C689
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5DE01F22A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEB3158538;
	Mon, 14 Oct 2024 09:56:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33492146D55
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899772; cv=none; b=dnWqXv7Tyqn7zl86yC9G4vipnzavc/svUumq3dYPCL48/91UBz5a521tXgAtsj8Rs5bGPM/iwfR2HKYTQPxcGAxniUVnzVV8F1GVurAB2G/gQsaJxP6CCF5XgKS6SC0GgbQ8K16hy/iod8+CXZdeGgWgn7CtqvYjuNiW5pcGkYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899772; c=relaxed/simple;
	bh=ng3uqlx2LrM7cGgb79FOyg5A2UDqKSVbXMKUEAAecKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nkLoaem/c7AhZfT62jwH/XjQL8InMDjnrbhXU1hC+Ql8JiDajNSFNl0Q31v+vd3zcN4TGu/fuB9nyvFaB+/Vjf1J5yFQ/XBaRPA8TQDYUQik9Jone0gUwc0N/HK8fGFKK/yJYrp+Q4IfQJBW4QH2+wwcekzUmMBPQjvoDvNHvJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 474A51007;
	Mon, 14 Oct 2024 02:56:40 -0700 (PDT)
Received: from [10.57.78.229] (unknown [10.57.78.229])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 197523F51B;
	Mon, 14 Oct 2024 02:56:04 -0700 (PDT)
Message-ID: <2f81fe52-2cb6-4a3c-8ab6-fe1b33d7a4fb@arm.com>
Date: Mon, 14 Oct 2024 10:56:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM/nommu: Fix typo "absense"
To: WangYuli <wangyuli@uniontech.com>, linux@armlinux.org.uk, jgg@ziepe.ca,
 jroedel@suse.de, robh@kernel.org, catalin.marinas@arm.com,
 jsnitsel@redhat.com, robin.murphy@arm.com, baolu.lu@linux.intel.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 alexandre.torgue@st.com, sza@esh.hu, benjamin.gaignard@linaro.org,
 arnd@arndb.de, rmk+kernel@armlinux.org.uk, hch@lst.de,
 guanwentao@uniontech.com, zhanjun@uniontech.com
References: <25F9FF4477394196+20240929081617.999000-1-wangyuli@uniontech.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <25F9FF4477394196+20240929081617.999000-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/24 09:16, WangYuli wrote:
> There is a spelling mistake of 'absense' in comments which
> should be 'absence'.
> 
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>


