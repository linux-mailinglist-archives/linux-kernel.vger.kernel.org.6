Return-Path: <linux-kernel+bounces-421523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348D09D8C62
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E1D281166
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B771B983E;
	Mon, 25 Nov 2024 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="AA+RMvFl"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4EA1B87F9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732560298; cv=pass; b=aSOriaNTCeAu8smGdhbaNkVxmYBxB4w2OY/HodrLIKOd6gvr8DvguORcbAgks3L0HDyREG84JK3YoVvBXUXgYZTK2fUhHy6xhY94FEM8gmgNeEN9rPssCA4Hp4PjHx2ZOI3gYjdgfOpbJQn4uZ+Ga9Iup2rAU11c0sp8L0e2+Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732560298; c=relaxed/simple;
	bh=98971YftLtogfAjqCobFcMvMek8cNjuZQQjyOQpbSeY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NhJVz2QDp3HxEnZndEvY2tH0DxEpYrcktNlQyjHqBZt1kvJN6X7rkeywJwUUfcEPjNXat+5NrPD4GPQFaiPdHBo2gJC+fG9W0lVsOklvbM8khdaa2s986157pnKNbzINaj8L6llJFLP2eqb1rGUNEhDvNZg0UWf6O0rGRGC2zCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=AA+RMvFl; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732560292; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hGWx4TzRPgP6AkJUFy4fyun1NIQEmwle/3dktbPpF1sAXufE3DhU8y/NUVDOBYMjFKeXjH6wPrzdo8t2EhhUN1zaKWNeaYS6VcxPws18ouh69h9BwMCqsJKW3xQHMlpAaJxUpnVraCdmSSOK5Bjgqamko0FeiaU9qiLhyM0ilgc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732560292; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mPRmRCWPFe8ce+yKDjvgaOMgt7zw/rnMu5Mp1rD7p5Q=; 
	b=labroysQFaMEhQqaEvSG4RB5BVTPJyPfxSQdPY3qAF8Ij2PSlcRHoUm6wXMZODmXhbZWGy5MuV0NQvH7Mf3+26OiP48vseZe+V9yiyrlLL1pWQrxfOlEZ50Gv/K+rPenbRghzplr+UoGf1P8DWQA5XUHeSOnZikivaiH6Ie2d3k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732560292;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mPRmRCWPFe8ce+yKDjvgaOMgt7zw/rnMu5Mp1rD7p5Q=;
	b=AA+RMvFl4xnYGlEQ1ZTpgmgNlkZHtWxeI3UVLCt3lgzfHnpX/O1xBpPsxRIArPsI
	IfZcQvKrfD2hIJhgE8R3oQyfSmQCmgF5PIBh+/BKKU/I0gYvL+TGfp2bZCZ+uK9NmCX
	QoU/D+vPqnoMriLriIpsPBxszQQJQ+dj097xRiPc=
Received: by mx.zohomail.com with SMTPS id 1732560290720156.73913293865894;
	Mon, 25 Nov 2024 10:44:50 -0800 (PST)
Message-ID: <20a1d49a-1f5d-4d3d-b59d-29b9791b72bd@collabora.com>
Date: Mon, 25 Nov 2024 23:44:46 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: userfaultfd: two-step UFFDIO_API always gives -EINVAL
To: stsp <stsp2@yandex.ru>, Peter Xu <peterx@redhat.com>
References: <2d35e5f7-2edc-4ef0-b71b-82186c0627b0@yandex.ru>
 <Z0Se4BuVfqwjeCWV@x1n> <b0818813-5a4c-4621-9810-dc7443a23dd1@yandex.ru>
 <Z0Ssq15MQd3rimBr@x1n> <da978e8c-2a72-4b7b-ae67-41e6ff0d5089@yandex.ru>
 <Z0SwOILi4R4g9JBa@x1n> <9b68a811-ffed-4595-83a6-0ef78a7de806@yandex.ru>
 <Z0S3isgc-QlEF7oW@x1n> <4689f014-2885-42b9-91a4-ff8b8133599f@yandex.ru>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <4689f014-2885-42b9-91a4-ff8b8133599f@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 11/25/24 11:01 PM, stsp wrote:
> 25.11.2024 20:44, Peter Xu пишет:
>> Apps who tracks snapshots needs the unmodified pages before being written.
>> Those cannot rely on kernel resolution because it needs more than "if the
>> page is written" - it also needs the page data before being written.
> Say I am writing a frame grabber
> (not exactly, but very close to).
> I monitor the video buffer of another
> process, and "snapshot" it with some
> frequency. I only need to know what
> pages were modified, to reduce the
> bandwidth to an absolute minimum,
> and if the process is not playing - then
> to not grab anything until it resumes.
> UFFD_FEATURE_PAGEFAULT_FLAG_WP
> works quite well for me already, but
> I envision a huge boost with
> UFFD_FEATURE_WP_ASYNC.
> What would you suggest for that usage
> scenario?
The UFFD_FEATURE_WP_ASYNC was designed for exactly this case.
The IOCTL will return you the modified pages. An example of usage
can be found in selftest/mm/pagemap_ioctl.c.

-- 
BR,
Muhammad Usama Anjum


