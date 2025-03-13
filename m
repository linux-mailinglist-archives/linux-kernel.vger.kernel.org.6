Return-Path: <linux-kernel+bounces-560238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3757A60098
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F9B97AF125
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F821F1513;
	Thu, 13 Mar 2025 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="ABhqq4Bj"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7521F0E40
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892695; cv=pass; b=fzC6KxJLCUXCiwkTPi/YAhlti4xwefxy+kjylfOqsq4yI/2yKYKLrCiqWe4YzHtn+W9tzzl5i4kf++NKnst0++iAIY8fU+zaVxtA+zMPy1+Q/m1MUopTD1TKeOy9e01dsO+aPQlDjempc/NPBXPpena14E6Vf9NunfNg1tXtyp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892695; c=relaxed/simple;
	bh=YoJzrJImw6IMtCjBzOmjeQUBz5qzMSUt+jqV80sKKzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFNo2tTNyh+nQp3rdDUHAQ89rIozLrRsc+dXhcpX5XYVojdA/Mtvvkhnp4ALlPbuLhvDJYsM9K3pBCo8sOxX+L6aNH9N0LexM3rIi1hLuu2leR2x4Je9zwjRdpZOVkidlVOF6gibbhN3z/h40E4mtptJ+nOR7UDH2NACx0g0STA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=ABhqq4Bj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741892667; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IDai2uCPeDltdnQDWMLspcg/wpWhfJjWrHiFe0Oxud8trPkbuItbTwPuFtBu2bKWZP5HQ1jy6RRWDZo0r+8GsE8DXHALA0KEoVM149PtwDyn8m3zvn9cfUF3NGPOMhmJGYBaAtYFNZeDzE2QQetK0Ueo04up/jXQuEMWEVHLz98=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741892667; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0oIWPDRciLqWE5onPVwFJiWQ7qoNl5vDCFa0WS9jdh4=; 
	b=DTujC8IarYC+WlMIUIA3V0dfkynhjraTTMeFsnB2KEqbUu/k3LXGKBkjdIs0fOtxrcMjuBJlTpGBIfK7T+54EpBTiRMzZ7opNtbGbrabZe6zfoBEY0AbYuobq32eCHgF92H/Fm+Ew1iaLsLH5OQspxGxoqHpn4yvbfOrRpWc5KU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741892667;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0oIWPDRciLqWE5onPVwFJiWQ7qoNl5vDCFa0WS9jdh4=;
	b=ABhqq4BjNTKf0mQ2n2Hu4xIa+Uv0npWPfJe4cdjtmkAbYQRP0OMUUrxvxZ70q2Cc
	Hs54FPNtEfwy1R3Gei2dh/xKBnyV7eTBO2jSGseJgJu8+a+2RONFS68nZwm7e5PeapU
	lHVS1KkEufwpimWodvMlv4XaWdzfcHP76NqFvYws=
Received: by mx.zohomail.com with SMTPS id 17418926658661000.7935840965962;
	Thu, 13 Mar 2025 12:04:25 -0700 (PDT)
Message-ID: <fa5ff28c-ffa0-47d7-9498-ef8b297c7afb@collabora.com>
Date: Thu, 13 Mar 2025 16:04:18 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] drm/panfrost: Enable AARCH64_4K page table format
 on mediatek_mt8188
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, steven.price@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 kernel@collabora.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, sjoerd@collabora.com
References: <20250310195921.157511-1-ariel.dalessandro@collabora.com>
 <20250310195921.157511-6-ariel.dalessandro@collabora.com>
 <20250311090649.0d15d74d@collabora.com>
Content-Language: en-US
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <20250311090649.0d15d74d@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Boris,

On 3/11/25 5:06 AM, Boris Brezillon wrote:
> On Mon, 10 Mar 2025 16:59:20 -0300
> Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:
> 
>> Now that Panfrost supports AARCH64_4K page table format, let's enable it
>> on Mediatek MT8188.
> 
> Can you maybe give more details on why this is needed
> (legacy shareability/cacheability not suitable for this GPU?)?

Ack, will expand in v2.

Thanks!

-- 
Ariel D'Alessandro
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK 
Registered in England & Wales, no. 5513718


