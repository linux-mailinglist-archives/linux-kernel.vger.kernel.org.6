Return-Path: <linux-kernel+bounces-322952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3005397358E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28A41F25D52
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B45184549;
	Tue, 10 Sep 2024 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Uw/UQxB7";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="UPYXPqCN"
Received: from a7-33.smtp-out.eu-west-1.amazonses.com (a7-33.smtp-out.eu-west-1.amazonses.com [54.240.7.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B674F23A6;
	Tue, 10 Sep 2024 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965544; cv=none; b=Kj8nvWAELx/HzQsOJloVViV+bEWlmNIhS0f2eJqm0jQSEdu3tpbyvuzXqvll+Z8ZlqHAHTh23fKmBTDvt5BTqPaU9poLw7/PSC0orcDpiJArF1V97gAZ/woFCOfmd5vxval3nf8bCNJlgYHMlE8d2naz9ndTDXZNkufLbOhEw0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965544; c=relaxed/simple;
	bh=oHfNoX1WgFE0WfNPPoO6VH/fExk0MByWcc4Y41dOXFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndbBpdSYhCdkekK5NcWaXI6KzCuLsZragqmi7aYrhtIooKZ4+c9M1+gkODRhIuOd6YhSiQGlyVxF7hkmKDocrrW5/8AaoMf/NeXL8x4ufbvYJBlNBgZ/b0Nunru7GcqKnp0TRsobmJUGAQfuSnOzSrYsTVT5GKA7NDz4gjMMbZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Uw/UQxB7; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=UPYXPqCN; arc=none smtp.client-ip=54.240.7.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725965541;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=oHfNoX1WgFE0WfNPPoO6VH/fExk0MByWcc4Y41dOXFE=;
	b=Uw/UQxB7kRwtua6Visa5NFKMeD+6bCDjCwgfCNgLkWIkBtiV6gkQdOIG4GJfZMy5
	yDNoR3jK1A8lV+Dl+UdpwVN+8OXYMY8D8LeRb89Vz9wkKxMBNMU0EVCL/VKDNGw8AH7
	MXvHiQYhYg03UfUG4uAqp0s7aeMqhP56HZd/KJX6ivq4gp1URC8uuEnpU17TpUXj8SU
	+V5Z0oqHmFDiLKcSVc7FXAXCVvnznuA8HfT1WEAzKSyY0aLmig5M+q9KrVjYZVzsn4x
	8KJC1NgnF+uRu5MVVY7aSWN+cXrMrJsM7Iy5YbW+Hluk7P5GiF/lnXvjMzNzVfExvST
	RtTjpe8uGA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725965541;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=oHfNoX1WgFE0WfNPPoO6VH/fExk0MByWcc4Y41dOXFE=;
	b=UPYXPqCN4IynNJClUxeQu234nL9lBI2mlOwsU3Xrzflyncz9XUEJL1uHJsBvkHrB
	BkkThpsCUP1J4CyvCKAh8KIuwkUqcFZRDs1k3bagj5AoqMJGwtSG4A8VgvwJ+FE/2ax
	j4rscSNQnIs42MAhpnb2EErzqwUkNZn+ErZjRdVY=
Message-ID: <01020191db901d32-5c318445-b8f4-4f4d-86db-316dc0db04ec-000000@eu-west-1.amazonses.com>
Date: Tue, 10 Sep 2024 10:52:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: mt8183: set DMIC one-wire mode on Damu
To: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	Hsin-Yi Wang <hsinyi@chromium.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
References: <20240910-one-wire-v2-1-2bb40d5a3cf8@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240910-one-wire-v2-1-2bb40d5a3cf8@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.10-54.240.7.33

Il 10/09/24 10:47, Hsin-Te Yuan ha scritto:
> From: Hsin-Yi Wang <hsinyi@chromium.org>
> 
> Sets DMIC one-wire mode on Damu.
> 
> Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



