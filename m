Return-Path: <linux-kernel+bounces-281638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F2194D924
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 01:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B212830C1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 23:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4939C16C87A;
	Fri,  9 Aug 2024 23:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVtoNGZJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8152443177;
	Fri,  9 Aug 2024 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723246526; cv=none; b=RQ8PzGaXRcCbXvJP+df7ImC39xVC8GZ9XIL9UErzJjTlNAHMBajI4l/omRCQuDiWXP+DluH4mqXrwW40hxXD9m6U99b6jJWFH3hwxeBN5B9LWCM8/BBLdvGcKNKHMIG+1QrUfkyZpNgq/p8lajPFnijspVbx/FwdRaqUIZ4mXFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723246526; c=relaxed/simple;
	bh=bnw2jiAE7VWK/3BhDqdjXZcKYHjaiQXpgQZiCGJdtXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oK+dg+Vw2HyFiJcg1cgF8VHwtWsrNtxS8yUsAmvT3lhy0sjg4CW9C3KG6TYypFftPX92S/aasctqqdg0WatO/KMKYm6mJpnrMggp3fb5OEGYIJ94dXkoDdkKtgn15zCNPVLdvfyct822QSQ05cOGF86FC1cIK+SiwoVkrKZZsXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVtoNGZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA265C32782;
	Fri,  9 Aug 2024 23:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723246526;
	bh=bnw2jiAE7VWK/3BhDqdjXZcKYHjaiQXpgQZiCGJdtXQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tVtoNGZJyLNclb/vOOVSbB8RlLZq7tHQmu1xPA8VyO9bekEgNH+Di9HY3T0BNT9Rk
	 lXKppkERsbib+tVKAsHX191xMimkLG2Edf8ffsCZ2uJfp6A1A8UkH5rJD5vb9Z+LjK
	 +E48e5T/+QI66K5bPSuX7Nypd+OsCfnSoyTQPGnwfHG23NtoBt8+0B2885c1BGNwpZ
	 F8Kggh8oQPzC5WfAPfEkqsx8SOpy3Ur6As6zJEHrvCxkSG5ktGlIGDKgkLBM6nV+Cq
	 EXQDlU3GN94fP1MW/b7z8Ezu45I5WDFKBavh7sa2NkzfrbNKrAP60My0MhyEKp3WsU
	 UoIdFZX8a9Sow==
Message-ID: <6027d9db-b1a8-4eb0-a0b7-451f1524834c@kernel.org>
Date: Sat, 10 Aug 2024 01:35:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: Add thermal sensor driver for Surface
 Aggregator Module
To: Maximilian Luz <luzmaximilian@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Hans de Goede <hdegoede@redhat.com>,
 Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240804230832.247852-1-luzmaximilian@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240804230832.247852-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5.08.2024 1:08 AM, Maximilian Luz wrote:
> Some of the newer Microsoft Surface devices (such as the Surface Book
> 3 and Pro 9) have thermal sensors connected via the Surface Aggregator
> Module (the embedded controller on those devices). Add a basic driver
> to read out the temperature values of those sensors.
> 
> The EC can have up to 16 thermal sensors connected via a single
> sub-device, each providing temperature readings and a label string.
> 
> Link: https://github.com/linux-surface/surface-aggregator-module/issues/59
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Co-developed-by: Ivor Wanders <ivor@iwanders.net>
> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> 
> ---

Gave it a shot on SL7, some names are repeated and one sensor is
totally busted

/sys/class/hwmon/hwmon66/name:surface_thermal
/sys/class/hwmon/hwmon66/temp10_input:32200
/sys/class/hwmon/hwmon66/temp10_label:I_RTS2
/sys/class/hwmon/hwmon66/temp11_input:31600
/sys/class/hwmon/hwmon66/temp11_label:I_RTS3
/sys/class/hwmon/hwmon66/temp12_input:38000
/sys/class/hwmon/hwmon66/temp12_label:I_RTS4
/sys/class/hwmon/hwmon66/temp1_input:43900
/sys/class/hwmon/hwmon66/temp1_label:I_RTS1
/sys/class/hwmon/hwmon66/temp2_input:44000
/sys/class/hwmon/hwmon66/temp2_label:I_RTS2
/sys/class/hwmon/hwmon66/temp3_input:47300
/sys/class/hwmon/hwmon66/temp3_label:I_RTS3
/sys/class/hwmon/hwmon66/temp4_input:-273100
/sys/class/hwmon/hwmon66/temp4_label:I_RTS4
/sys/class/hwmon/hwmon66/temp5_input:31300
/sys/class/hwmon/hwmon66/temp5_label:I_RTS5
/sys/class/hwmon/hwmon66/temp9_input:37100
/sys/class/hwmon/hwmon66/temp9_label:I_RTS1

Konrad

