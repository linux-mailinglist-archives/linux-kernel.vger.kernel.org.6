Return-Path: <linux-kernel+bounces-386691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941539B4704
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32DA1C20F66
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BDC204934;
	Tue, 29 Oct 2024 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=helen.koike@collabora.com header.b="NrIlgmI+"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09A117A58F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198272; cv=pass; b=UtIqS72HeiPqphw1cYKGtOgvxwdNSXI8OD29d4x0NR9VLZUJj/Edt2Oa5P/ggBEHfAfbSbxDkPsgOEKIkzPxXtLwcGGM1Bd4ESAgeJQ+Sw4gS9Sm1AKKDLecP/4CcS3bIfnu7jzjhaAMIsxIk1XtZY1HzBt+aeLC0TUk18DkR5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198272; c=relaxed/simple;
	bh=OT32NOV5ZbV83eByjZy0l98uGBOMhCyXh6mMkev4rL0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fpe+GD817EbIOzcWI+gga1UDnJ4wY1/+X0hMlNYUsl8uKv1PXPFVKh+9McM9dHTW2Epsn/+SYl/H5EJjD+vlVq99jqZ6p+EpV/ZJXh6k8ko8cbFB9Mk2LDQRZTdanoixkRNbLPMpbxhfSMJM6vzt9/Ed0DVK9btEIEbiFIP/3Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=helen.koike@collabora.com header.b=NrIlgmI+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730198255; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=W2ehznKhZDjYLGdDx38cfD79903b/kCP59/EGgrZx0m9KcjtP+vLC0nCSnDDgyoPt3vT5pPir/8lVwItEmWuiROris3Q9WFvwbxMrNpuh27Ch09+caO9QZAyW8AQeWiZWeO70nQMirW8yKEldlonmA75E7ERM0TVYdrqzJKplAc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730198255; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LNMy/MmJuQOJdLUAUIHy+ZV0WQSxzJ0h2MDmigRTDqo=; 
	b=AX73lXN/KE8GkPOewfoJ8RjYw/0aLqZlxwP8Iyhd3r/55URU16kVTvAJFDKknfjjDw9uukAXEk3TTq6JUomhhsa6KRIpa+dG8c9CWvcekuT1BCF5PqlL7RbzR6Qmwz7K3XXe20smoA1CNBRP/Xb9jARr6+k0FqAdRuQ4Kuw07B0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=helen.koike@collabora.com;
	dmarc=pass header.from=<helen.koike@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730198255;
	s=zohomail; d=collabora.com; i=helen.koike@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=LNMy/MmJuQOJdLUAUIHy+ZV0WQSxzJ0h2MDmigRTDqo=;
	b=NrIlgmI+4M88tTfkK0dtz6srMU9kOvI/rEDwjJlWiRjeeXuJvrmT80dFGewHSA+z
	3qg3LnD+uEtcoNxuhN9O20FYJ3Psssr7u6a4NR66grcoH4G6aO2kbNh9uwbcz90Hh2R
	Mi3zstzZbv86avx7mD3yeO8uZ9bFktrCC+txYsZQ=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1730198253399319.6794373787027; Tue, 29 Oct 2024 03:37:33 -0700 (PDT)
Date: Tue, 29 Oct 2024 07:37:33 -0300
From: Helen Mae Koike Fornazier <helen.koike@collabora.com>
To: "WangYuli" <wangyuli@uniontech.com>
Cc: "maarten.lankhorst" <maarten.lankhorst@linux.intel.com>,
	"mripard" <mripard@kernel.org>, "tzimmermann" <tzimmermann@suse.de>,
	"airlied" <airlied@gmail.com>, "simona" <simona@ffwll.ch>,
	"david.heidelberg" <david.heidelberg@collabora.com>,
	"dri-devel" <dri-devel@lists.freedesktop.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"guanwentao" <guanwentao@uniontech.com>,
	"zhanjun" <zhanjun@uniontech.com>,
	"Vignesh Raman" <vignesh.raman@collabora.com>
Message-ID: <192d7da2f2a.1069aaa001047791.5583301334791429946@collabora.com>
In-Reply-To: <11312D359DDCA3CF+20241017034004.113456-1-wangyuli@uniontech.com>
References: <11312D359DDCA3CF+20241017034004.113456-1-wangyuli@uniontech.com>
Subject: Re: [RESEND. PATCH 1/5] drm/ci: Upgrade requirements because of
 bothering by GitHub Dependabot
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail





---- On Thu, 17 Oct 2024 00:39:48 -0300 WangYuli  wrote ---

 > GitHub Dependabot keeps bugging us about old, vulnerable Python packages. 
 >  
 > Until we figure out a way to make it calm, we're stuck updating our 
 > dependencies whenever it complains. 
 >  
 > I guess it's a good thing in the long run, though, right? 
 > Makes our CI a bit "more secure"... 
 >  
 > Signed-off-by: WangYuli wangyuli@uniontech.com> 
 > -- 
 > 2.45.2 
 >  
 > 


Hi WangYuli,

Thanks for this.

tbh, I'm tempted in removing the python script that is in the repo, and keep it out-of-tree somewhere, since it is a tool that is only triggered manually in local environment.

I also want to hear Vignesh's thoughts about it.

Thanks
Helen

