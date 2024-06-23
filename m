Return-Path: <linux-kernel+bounces-226023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21772913930
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 11:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC7E1F21853
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 09:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039E07442F;
	Sun, 23 Jun 2024 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=froggi.es header.i=joshua@froggi.es header.b="dp462EXw"
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83BAD268
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719134487; cv=pass; b=PW8X1uui7D18sH7OAe7t3jkJ4DysoRo6VQlikrlyuJ1jYmTVx1xqiYtHkvsCBW8NqBNdI5oo58qETeUPezcSdMgJkctfEbqTUCxHKbjoKyGrOKnrJu9chURgAOI8bZoD+24s4QBxR5RWuWcAiHghEiBZpNHcNZAtx9vo3tUuCuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719134487; c=relaxed/simple;
	bh=E7Pm7Kft3RPd0kI3illLUNXSTiNgHWDVYiVQeFiogng=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=AjqIQSjU4tRrUdNQWVtrXgWwp4L6kx9LE2cIuKH/au+quZWYuxA5ODXfBhUO9l9D642uuFPSOlWBXUq3koL3pw2MDbhYXUYDiF4JYW/ZzKdA5BYWYL500DPGTLBy0MqyNr5S8/2lqfUFrKr9AW7ECXEI55OsJ+jW08vHCUl0zgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=froggi.es; spf=pass smtp.mailfrom=froggi.es; dkim=pass (1024-bit key) header.d=froggi.es header.i=joshua@froggi.es header.b=dp462EXw; arc=pass smtp.client-ip=136.143.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=froggi.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=froggi.es
ARC-Seal: i=1; a=rsa-sha256; t=1719134464; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jg4pz1J7JxCUsIJ4NLlfVPom93hsXUjUUklYldn77UlW1J7vITR63f340Zjj7dP7VhhD/BbgdI7NJk+baaWW37SEBOUcb26sxcFXo1NMqwiDD2THPvLf9kyzvgbHvBaEWfaTcpF0qLQd6+Im1MRVNvX1FmZjZgHAD6wz3WGMN8o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1719134464; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IDRH7REOOmEJVw8zchCha1EpfhlNdrhZ3hVqEhf5ZDA=; 
	b=MsSiiiNraGuq7rO7jSAE5pvPrbAbhQ+RGkq8aDHqYxv4hkC4zD2iiFSyBlwR8ITo3C+F2CD7ZI+NW+eAXIC3Ma1Mv6tQ5agPMAtysLYKSk7v8ZqYfLnN+bjgE6b1tBL6JWV2RTl1t9sP4HGFL6q+LnYK4JJurS4Y8ML3Fm7Dlz4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=froggi.es;
	spf=pass  smtp.mailfrom=joshua@froggi.es;
	dmarc=pass header.from=<joshua@froggi.es>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1719134464;
	s=mail; d=froggi.es; i=joshua@froggi.es;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=IDRH7REOOmEJVw8zchCha1EpfhlNdrhZ3hVqEhf5ZDA=;
	b=dp462EXwNpqN6bQk4NBsK7Y0qJQyW20U4EEY4OPuoFpZSSz17grCq5Ih0dxMkIlW
	bskDHbsJFp5QPIJ3M2boxH7yxEQ5yoRSFxGVtq4Q4Bztg3Ns/Qo6niPZr6H+1KMjTtS
	+Nll8F0KM6XmbJwuZb8gZDeTX9/0JEAH5FC8jJCw=
Received: by mx.zohomail.com with SMTPS id 1719134462217433.4917300655152;
	Sun, 23 Jun 2024 02:21:02 -0700 (PDT)
Date: Sun, 23 Jun 2024 10:20:57 +0100
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org, Ma Ke <make24@iscas.ac.cn>,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, srinivasan.shanmugam@amd.com,
 aurabindo.pillai@amd.com, make24@iscas.ac.cn, guchun.chen@amd.com,
 chenjiahao16@huawei.com
CC: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: fix a possible null pointer dereference
User-Agent: K-9 Mail for Android
In-Reply-To: <20240622082219.1876200-1-make24@iscas.ac.cn>
References: <20240622082219.1876200-1-make24@iscas.ac.cn>
Message-ID: <C5F9411A-0396-4B7F-B6D8-38F2C067283E@froggi.es>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Are you planning on submitting a bogus CVE for this patch too?

- Joshie =F0=9F=90=B8=E2=9C=A8

On June 22, 2024 9:22:19 AM GMT+01:00, Ma Ke <make24@iscas=2Eac=2Ecn> wrot=
e:
>In amdgpu_connector_add_common_modes(), the return value of drm_cvt_mode(=
)
>is assigned to mode, which will lead to a NULL pointer dereference on
>failure of drm_cvt_mode()=2E Add a check to avoid npd=2E
>
>Signed-off-by: Ma Ke <make24@iscas=2Eac=2Ecn>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_connectors=2Ec | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors=2Ec b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_connectors=2Ec
>index 9caba10315a8=2E=2E6cf946adb6fe 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors=2Ec
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors=2Ec
>@@ -458,6 +458,8 @@ static void amdgpu_connector_add_common_modes(struct =
drm_encoder *encoder,
> 			continue;
>=20
> 		mode =3D drm_cvt_mode(dev, common_modes[i]=2Ew, common_modes[i]=2Eh, 6=
0, false, false, false);
>+		if (!mode)
>+			continue;
> 		drm_mode_probed_add(connector, mode);
> 	}
> }

