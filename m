Return-Path: <linux-kernel+bounces-553058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541DBA582EA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 11:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F028164568
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495301A00F8;
	Sun,  9 Mar 2025 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RHKbmtlj"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0504D189F36
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 10:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741515078; cv=none; b=YEvzGGf7g3RGNP6wNlRuNdqKKxP+bx7tzmFP+3bV7WX0ZwICkAujhfvteuFYj35pydN8ICDJtjVJ69n5b3HPPvjU8+wp3aZFZAzKdfCdnT8ZSGMx3H/c/4ohrHPKzbIjX3n7IL3xPBHJMQ7SP+J0MbfEHh8ZuTax7l3/M8obQYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741515078; c=relaxed/simple;
	bh=sQra10c30MYmky155tTp0EkDPmDnARSe2sYZR6ySckU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bur54MJ7OJP6e0vPfiW8IsTuGTtNDrJa0b6C220zPgsl2YWhcmuBdFJgcuODn8JaO33oCe59uL4Rn0RMcQFLd41+XgCYi5HEuiW5/J37tuPgR2vqDaX3aLm2bqAGls0GM7cczzmWQ/EMYobddERhCoQI+Iv8hCojgShoz+5GpqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RHKbmtlj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741515075;
	bh=sQra10c30MYmky155tTp0EkDPmDnARSe2sYZR6ySckU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RHKbmtlj+KMHs2L793B6DvggLvnoRIlmnAfp8wcnileSwLHbHLAI9+B/HeGN/0uLw
	 2M1R4e8y6tG9LwnZ1ya6kVOzmldLzlMZMnogOXmmW+ZJCSz+liqVd5JwYCUZ2eZGep
	 ZnZ7h6PUuVENMBtL0BfC5kskKjRLi70qfJ9eIe1aSQbU0hCl8yDWI0nXIiTiSecc1B
	 yl2z5bKSQDgwaleDLirXARJN9ljEsofhUdc8AnZPMuuG8LnMBBVAT4wfOSbcDxsDfx
	 X9QlgTtZFZ8TI4ta0rhpna3gn7bFZlGGd48U0ZMO874Wt/MlibrKI3seqszUz9MM80
	 3hmDBhbizPr5Q==
Received: from [192.168.1.90] (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C052317E05C1;
	Sun,  9 Mar 2025 11:11:14 +0100 (CET)
Message-ID: <f1e33b02-5646-4219-98ac-c09e31d8215b@collabora.com>
Date: Sun, 9 Mar 2025 12:11:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/12] phy: rockchip: samsung-hdptx: Fix clock ratio
 setup
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>,
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
 <20250308-phy-sam-hdptx-bpc-v5-3-35087287f9d1@collabora.com>
 <CAA8EJprBcGz0tZ5SDVC_WK2bzjXZAtOj+LfGnSxmwktvaQw=VQ@mail.gmail.com>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <CAA8EJprBcGz0tZ5SDVC_WK2bzjXZAtOj+LfGnSxmwktvaQw=VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 11:17 AM, Dmitry Baryshkov wrote:
> On Sat, 8 Mar 2025 at 14:21, Cristian Ciocaltea
> <cristian.ciocaltea@collabora.com> wrote:
>>
>> The switch from 1/10 to 1/40 clock ratio must happen when exceeding the
>> 340 MHz rate limit of HDMI 1.4, i.e. when entering the HDMI 2.0 domain,
>> and not before.
> 
> Am I correct that the only functional change is a switch from
> greater-or-equal to simple greater?

Yes.

