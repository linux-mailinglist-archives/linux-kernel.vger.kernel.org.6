Return-Path: <linux-kernel+bounces-418282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFC79D5FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86601F21E36
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABF51DEFE0;
	Fri, 22 Nov 2024 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nicho1as.wang header.i=me@nicho1as.wang header.b="QusvSGBm"
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A17A2309BF;
	Fri, 22 Nov 2024 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732282099; cv=pass; b=gAS2dZZLlpwE6mlKFaU82KxiSWqBIG6tr8ADweoKpF5ysLPJR/mDPB6ATP0Pfkx89Vp7RmjuLhyqHEGUyek/LUwTFPm6ScYtDu5mVvQLmhbrWzRUI6dkZ6/HFlWObLBqxGAqHKP4Fal7ls6IxRhfsy0Xs2Y98ZtOtUt9/zErghA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732282099; c=relaxed/simple;
	bh=81flN/bRO2GwfhEBwoK6KYmjoOXil+b0HhFShZULjzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuWNIADBVr28r0BPWMgtVFI2yGUTzNnC/ju2L8x2Ie/idvH+u423Ampx0lHe4C1rF+A5VoJGhLFZQoQpCYJq+13jDgZAbCF/xlJwOArY1li/s6ZdEvlp6j1zyXpKWjzRIjsN93IOAjH8R3b0QdSjbFuLAIutBNg21nHOnHuQ1/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nicho1as.wang; spf=pass smtp.mailfrom=nicho1as.wang; dkim=pass (1024-bit key) header.d=nicho1as.wang header.i=me@nicho1as.wang header.b=QusvSGBm; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nicho1as.wang
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nicho1as.wang
ARC-Seal: i=1; a=rsa-sha256; t=1732282088; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eY0HRjBL/BTNmbKSxDJEsUvIhivgDyZUJRcCzIKHm/7QMa0msF9BjKA585mmRMMNUlBBNdchppcQbfTT7gfzFFxNbUzrbso83FvORtF86lcRXKhHj+UVvnck4qx/3gVtzmt8t0I6wqCrfYtoB5BTFYnDJfO0fwGbm3ZFXdcxBZc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732282088; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=81flN/bRO2GwfhEBwoK6KYmjoOXil+b0HhFShZULjzw=; 
	b=HeZA2FjumkhqjowPoRrtA1OT8vd4zCfWKPLV9NAv97eJb60ArcdtlWteIq0E9CJAB+S2gZM9WuywahhXo5yDv0xTKj4mw6MmwLUujJnu3O0OJYDYlzm6Ji+vFUFDPkhpuN72jJ5raQ2S6cwBR6Knf0Kvd3l/btGocv1DupZ8lEs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=nicho1as.wang;
	spf=pass  smtp.mailfrom=me@nicho1as.wang;
	dmarc=pass header.from=<me@nicho1as.wang>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732282088;
	s=zoho; d=nicho1as.wang; i=me@nicho1as.wang;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=81flN/bRO2GwfhEBwoK6KYmjoOXil+b0HhFShZULjzw=;
	b=QusvSGBm42tjB9H/DTMSDJLIZ2t7LQ1xdNgYP8AtiO2C0V3UERrKJkFJznG6XTyN
	GUe5t5q97ROl8jc8v90J7uJmhJ+oycF16B4t2edpeT9KM/xtXr/lWws7OhbkLIChxjR
	24DnfCM/+4MMWU/pInXOn2QGcz0/JrttwGS/Gijk=
Received: by mx.zohomail.com with SMTPS id 1732282083899932.6589035021757;
	Fri, 22 Nov 2024 05:28:03 -0800 (PST)
From: Nicholas Wang <me@nicho1as.wang>
To: sbinding@opensource.cirrus.com
Cc: david.rhodes@cirrus.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	me@nicho1as.wang,
	patches@opensource.cirrus.com,
	perex@perex.cz,
	rf@opensource.cirrus.com,
	tiwai@suse.com
Subject: Re: Re: [PATCH] ALSA: hda: cs35l41: Support HP Elite Dragonfly 13.5 inch G4
Date: Fri, 22 Nov 2024 07:27:17 -0600
Message-ID: <20241122132717.112480-1-me@nicho1as.wang>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <de0f8e31-f1ca-4a96-99a9-45439c7463a7@opensource.cirrus.com>
References: <de0f8e31-f1ca-4a96-99a9-45439c7463a7@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Stefan,

Thanks for your timely reply. Unfortunately, I'm not entirely sure about whether
it has a valid _DSD and yes the patch is prompted as this laptop has crackling
sound whenever the volume reaches around 30% and easily triggering "Amp short error"
whenever it's around 50%, while the volume sound weak at the same time. I believe
multiple users across different distros are having the issue, but I didn't find
a corresponding BugZilla report. I wasn't entirely sure on the entries I added,
however it is verified to be working on my machine and one other from Arch Linux
forum. I created https://bugzilla.kernel.org/show_bug.cgi?id=219520 and had my
dmesg and acpidump attached there.

Also these are my very first patch/emails on the LKML, so please let me know if
I did anything wrong.

Regards,

--
Nicholas Wang

