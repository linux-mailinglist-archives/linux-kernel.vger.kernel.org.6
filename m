Return-Path: <linux-kernel+bounces-445871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F9A9F1CDD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 06:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F50188D3DD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 05:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1725C13212B;
	Sat, 14 Dec 2024 05:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PLA9k4SH"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8F6B674;
	Sat, 14 Dec 2024 05:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734155902; cv=none; b=EO1nXdchV0SuE3PNMc8UUlcWrf2urwUiZzStGI2BGMJB1N/gEZm/CWKoeLBvbleJdbf/9dlmEGdFec5Cjh2C7G1v/XxTRmQdQg6TUXkRqpbK2CNz/1UkRRdXsw91uWFMaogA/RuoN6wupAlJPItEhf3GCeAnAnj8Hs5pEA+GWog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734155902; c=relaxed/simple;
	bh=DBcLI9EkDVPyEV89HGPQQw2o0MXR33WbZswv7eYg9c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXsg0DmpTQyaNYrBqSQSeVnzUzskMicee3i6W0f3xsVvT46qQyjGHa7m+GrkNVVSVuUiXmLALCm/KSoNw8QDngI77yjj5l6213YKZBZ7F9XghMTlmV45DpR/1KKYqyIBxFv7TWj6ZU7m9SbE3uAUHeGw6aI+SioxN158/SlbkHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PLA9k4SH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=pq3ikiqwesjWA8IF+cN+2bkuFlEoo1rAR6e7R5w052Y=; b=PLA9k4SHhVijNoceM0MbHkGVay
	IAeFJkmYYBG4deUSCK2GMIoPZYmfdlym1EGKtVuN+3wMpP8lgz72kLh/JfTEf3LDYIEBLEtu3nHzl
	DG25mrmcykk3ICp7fxTOW7CJsGwiIEs8ymaShbNRCVbbUlujAmL/QSg94ogJI4NFJyPURdEG2cqk+
	D44a5t7KmUlKnebOzxfdFv6uuB/8CJperhuNU4df9hRg9Aoz1tiC7zz2f+zUjto7VwLiGjK2T0tdx
	k+Y/eziudD/9lySmdI7jD+vSuMgWaOR5D6yuNpTBg/bUXyctTNmBnUPnFjsGzc9d2wl9VJEVwr28L
	OMJYi1YQ==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tMLAP-00000004OqD-1Wyz;
	Sat, 14 Dec 2024 05:58:17 +0000
Message-ID: <b4361cda-a24d-49d2-9377-cbdd68124deb@infradead.org>
Date: Fri, 13 Dec 2024 21:58:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] docs: admin-guide: join the sysfs information in one
 place
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20241213182057.343527-1-corbet@lwn.net>
 <20241213182057.343527-2-corbet@lwn.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241213182057.343527-2-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/13/24 10:20 AM, Jonathan Corbet wrote:
> The documents describing sysfs are spread out in the admin guide; bring
> them together in one place.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/admin-guide/index.rst | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 

Looks good. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

