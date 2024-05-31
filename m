Return-Path: <linux-kernel+bounces-196827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5042E8D623B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D731F26A68
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E625158A26;
	Fri, 31 May 2024 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jxKNogid"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92764158A17
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160130; cv=none; b=soZIM0mcMvVjY6xco1vzT46dJdKo3Jznt+tfhObg7PeaR2mp0tZfKugSCsY9RLhpMIGZCi0PxzHi3p2LBCYgBkuFkqZuKsVykxW7v77jfs58y1N5fduAIWC31YarXOMhsdtcJ5BokEyw/+oH/4GbYX03KtKmd96LbZ4QLpcGTYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160130; c=relaxed/simple;
	bh=mDqBiIbi/4yxm6zJ75PqcXSsLMeSwUbUaDhGcBu3OHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RTwUluKEN+nzFv6jisXW9BTEY86vxCsCEM3dOG1s6WamxA2MjdCLNBFQOowBJ8bFnKm6Nb6tw94NNqSPZNNMxak+Z/R8+wBBvDHDRRdPDU9Yagowi6vXZpDMpr76ieOlStUgOEJzFRBlE/zA7R+qKMFz+XGuyPhG0/QRESHUkT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jxKNogid; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: j-choudhary@ti.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717160126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDqBiIbi/4yxm6zJ75PqcXSsLMeSwUbUaDhGcBu3OHw=;
	b=jxKNogido9tKkoNsMpPs8ZjlJaFBXEfWdqvquvV2po66Qhl+FJ72SNmfsGYC1OGfAcWtm0
	j2s2PekNDUTWOeiiY71DcnXbBP7XS1Rot36f5jGjNiUg9huHbeDYFeQSg7GCBJr0AIS4a1
	v0kWXxY0Q7/RekmcB7hcjm6kjutQyM4=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: dmitry.baryshkov@linaro.org
X-Envelope-To: andrzej.hajda@intel.com
X-Envelope-To: neil.armstrong@linaro.org
X-Envelope-To: rfoss@kernel.org
X-Envelope-To: laurent.pinchart@ideasonboard.com
X-Envelope-To: mripard@kernel.org
X-Envelope-To: sam@ravnborg.org
X-Envelope-To: jonas@kwiboo.se
X-Envelope-To: jernej.skrabec@gmail.com
X-Envelope-To: maarten.lankhorst@linux.intel.com
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: airlied@gmail.com
X-Envelope-To: daniel@ffwll.ch
X-Envelope-To: a-bhatia1@ti.com
X-Envelope-To: dri-devel@lists.freedesktop.org
Message-ID: <ba038d60-e399-476d-a4f3-50fc9d8eb390@linux.dev>
Date: Fri, 31 May 2024 20:55:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/2] Add mode_valid and atomic_check hooks for sii902x
 bridge
To: Jayesh Choudhary <j-choudhary@ti.com>, linux-kernel@vger.kernel.org,
 dmitry.baryshkov@linaro.org, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, mripard@kernel.org, sam@ravnborg.org
Cc: jonas@kwiboo.se, jernej.skrabec@gmail.com,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com,
 daniel@ffwll.ch, a-bhatia1@ti.com, dri-devel@lists.freedesktop.org
References: <20240530092930.434026-1-j-choudhary@ti.com>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240530092930.434026-1-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 5/30/24 17:29, Jayesh Choudhary wrote:
> Move the mode_valid hook to drm_bridge_funcs structure to take care
> of the case when the encoder attaches the bridge chain with the
> DRM_BRIDGE_ATTACH_NO_CONNECTOR flag in which case, the connector is not
> initialized in the bridge's attach call and mode_valid is not called.

Good catch, as modes being supported is actually a capability of the
bridge itself. The move make the driver reflect the hardware more.

