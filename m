Return-Path: <linux-kernel+bounces-576298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81782A70D9E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572473B5BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75399269D18;
	Tue, 25 Mar 2025 23:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="GOhtQcQe"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703C019ABD8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 23:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742944990; cv=none; b=drNFjr1rXZ0LkYTVZz4um1fEmABDawirAwpo89Y4lSYoP85bZAij6kduQDVyoGHO5mGn0s4sVyPHCYhDo2LPXwxqQCkPoqV3HAHCtjKm4gyIum2xpwzyeuMAthrv3eotd6V6rOZqwodOle1E3H7MTU+dPo5dSv1IAThnv1WND/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742944990; c=relaxed/simple;
	bh=aiAGn8HR5QAxkXOqoNEse2IFUoHOXlm68nmF/CqfwHE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uJ0ayRpmmIkCuN4w/BbEb+CQWaveEwp8C5K8BqN0rdJgQBTpSmo9n9SpzLGLNfWHlGrSztFqRtVjuoXNypmR+4tz7H8JDOabaTIBIyTjmCE9k/4I/r4rd5iPkJX3/hXCRKbU0QHRxC6C30E7gWUg17xyN59dk79CsgepeInot/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=GOhtQcQe; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742944957; x=1743549757; i=spasswolf@web.de;
	bh=gY8B9GBQL9nUHTRbQamIZos1rVDULEBsh1sN+fH5oGo=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GOhtQcQe8sat3+iobd73xdx1RHz8WbkQHKOw+JPg+WeIy5pzxIC1FMKR+HdDzS0z
	 PLNNBFgeNweYRmcSF1ISyUE7M/UBb4vFt+jnNXkj70KEqyBu+6wHf0zxurT9vurso
	 Zq2gsGhweS7dJTkR205cYlHF60o8ky4HjibDv6lMauOMorRkfDrJO0mVvPWvf7GlO
	 Ze590lN+3cEyeXagF1BHr4uKSdrVVqPm9oGGtPOPHAsMR38HV3RhtC1HKgITBxvWy
	 AP4WOkoLSt9N8YIQcmU+Pbf1+XseUylUZV5rd+jMsQzx256BV06HRWJ0HPldZ2+jM
	 Mrh/uv2Ql2r+7wyGwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Myv72-1tASSt2Ayo-012jIk; Wed, 26
 Mar 2025 00:22:37 +0100
Message-ID: <eb041c610719c8275d321c4c420c0b006d31d9f4.camel@web.de>
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Bert Karwatzki <spasswolf@web.de>
To: Balbir Singh <balbirs@nvidia.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
	 <christian.koenig@amd.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Alex Deucher	
 <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, spasswolf@web.de
Date: Wed, 26 Mar 2025 00:21:53 +0100
In-Reply-To: <261e7069-9f65-4a89-95cb-25c224ff04f1@nvidia.com>
References: <20250322122351.3268-1-spasswolf@web.de>
	 <688f2757-e364-45db-ad54-daa6ff1c4f3c@nvidia.com>
	 <6e8ad3cd27b570aaefd85395810cc90bb3120734.camel@web.de>
	 <7cdbe06c-1586-4112-8d27-defa89c368e9@amd.com>
	 <b1d72b95-5b5f-4954-923f-8eebc7909c4d@nvidia.com>
	 <938c2cbd-c47f-4925-ba82-94eef54d9ebc@amd.com>
	 <261e7069-9f65-4a89-95cb-25c224ff04f1@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VOOYiLoMShOoiud3+Nvf9dJHlrBFUOfbXbOX2rAweYFMDUO3oAl
 yKiaZIcoBV8/mMfnmn5wQQ35A+U8QrbCBKyJ/dXxNwu91KbBIqxv48wuGXoI+bjspavIeX3
 UOzGW1SCHtaVCHbtc25eupk/bGDTFpD+GgUz714Cz4AhBX7INVs1MIffJVHHEwt36NILool
 uWQkN1WzGzDZwlgnbnsyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2gzskj2BU/o=;d0gTqL3GqAmtRzdUT0j+Q8tFfVa
 5GFu70rSv4eYkvN57UrTXRSqslZMW9JGjuRHOFlFuY69+SVcQI2BbHw1dLyLSs39fBPgEgdvC
 IvEm13d6IOsjd/CejCXteFVFm3HdxkLa8SJovOERPNZsYNXOYT5Oy7HpjN/IYPflIEG7bcvAf
 jm/KoK9QFrDxWMRQqRHp6u1zQXnhuqH5O/0IWeKoiObP+YVDVA+cwyY4IQyWXjA/GulNBPhNY
 CrNwNwoR/UF/N756AUAF/xnRItqcm5XBQA1JFmuFVmCZka4CjiSSPRtmaEGj2l9b7OAV3MSNV
 0YnYVDcP87tMYd6m+zFUTyiRaVhTtXdYacznSgdUIL0jmFX7PWDn5kB5sHyqb9sSOgUoZfqLw
 nAkMhMKzsZHZ7ft8kN51cwA6Sh/G2G3hb/Wy+j+a+RkKUujlC3xCQIQ3BVhypov3x53kto4Kb
 dU5m0qDWfrcrf9SpSVTNwb6VSQHxfvRd8cNw+YPpn0V7EmXkfEehGAyVnpaQxnb4EPfScmxFq
 OIcKbT+9VK99gpddxPqiU7uORHU5KxNlHG6uyU759jFFVUFkO3aDxjrIIavygKcyxmYOrv5dC
 DUI9oYEZxNvYMXnP1EtiIFSzvfBuO/nd45bcfJjGHgTC2yjAwkf26t7O98BEgeCXtlCkXQ2Hy
 Gb5BTMI5/k/saueIpWUQNug9bHgaMIkN2pgxQJcb1xKD+XVR+ZqudHcPNiOSEe0psQU2kyf6K
 vBu2gouMqadEab7y1BOEexKmeL4nJGZ3JKhTVSN6xwCC31BH69VsVwws9e50p+Rlhk112sxJB
 02ubfgMZvAayDCpQ+tL9mkjA3v2v5QwuaogpY8q0+o9ff62Okaq+srqUOADzO0WHF0hizOZUW
 VDJu42qbf52SYTo3NT6nq8EzrXSEmXPO8XW/A0Ll6zR4ZzZdu260wBjcHRoTilX5M4w4GVNKA
 i2aMsLxuZyAsHfjvp8yUQZDNIvURH0uFafRN+h+VMvXa6PeezI0YaanYcY09ZsJEw3LZs/tuW
 tra0T/L0htAeUYIwc5/Zw6eGF6LgnLYpVnbOTi2rcPPZF1DtzbAmDuaeVSj0CFqnU0epHisvg
 YsaRp9M7esKX9xRuoXITpp3EXgftMBj5AAK9iQqzGEOl7AeV0/5xTOH/mRPD21Zmj+AjImnj5
 ogfRMam0cnOnI5qPhL1rtxEbzyRSU4x0rE7FGHlK99G+LHAI+pUpitKDPqHbd2Qz7u4o4F4al
 xTNPgyyltbrgnDNVdkmvlXitGq/EKWlX9RjC/6q8fLsO4pJNLGJte6wMLEb7WP7eQHL79QG/i
 3IMKj2a7W+CKpeBFtjfu6DJDPWtZfibdIwzKupY+nMnW7Jgyk0w6BFBX/16aXwluTmyujVuG7
 hC3xDOmU9yZ5O8ps1GgmWexoocTwuQpy2ZGraX1J91hwILw8oIV6VNerhQz/szxbGakHoiFs6
 1G26J0d0BzTtwKsbAmoYa236XlEQ=

Am Mittwoch, dem 26.03.2025 um 09:45 +1100 schrieb Balbir Singh:
>
>
> The second region seems to be additional, I suspect that is HMM mapping =
from kgd2kfd_init_zone_device()
>
> Balbir Singh
>
Good guess! I inserted a printk into kgd2kfd_init_zone_device():

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index d05d199b5e44..201220e2ac42 100644
=2D-- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -1049,6 +1049,8 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *a=
dev)
                pgmap->range.end =3D res->end;
                pgmap->type =3D MEMORY_DEVICE_PRIVATE;
        }
+       dev_info(adev->dev, "%s: range.start =3D 0x%llx ranges.end =3D 0x%=
llx\n",
+                       __func__, pgmap->range.start, pgmap->range.end);

        pgmap->nr_range =3D 1;
        pgmap->ops =3D &svm_migrate_pgmap_ops;


and get this in the case without nokaslr:

[    T367] amdgpu 0000:03:00.0: kfd_migrate: kgd2kfd_init_zone_device:
range.start =3D 0xafe00000000 ranges.end =3D 0xaffffffffff

and this in the case with nokaslr:

[    T365] amdgpu 0000:03:00.0: kfd_migrate: kgd2kfd_init_zone_device:
range.start =3D 0x3ffe00000000 ranges.end =3D 0x3fffffffffff

Bert Karwatzki

