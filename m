Return-Path: <linux-kernel+bounces-326652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F77976B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0747B1C236F0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005041AD258;
	Thu, 12 Sep 2024 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="ajJHD1qi"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C8F18028;
	Thu, 12 Sep 2024 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149506; cv=pass; b=kyhjXFd4r97NUpjZiqg0CDB9L+H05Qo4ojV/PSZHPic2B0o5OKTNiwYOaxOmKoxyRROAOwkT7bgiLWN+NUzVlEQsBY810BJpacpwDIQNofK20usrsiPBLSrGTLB2WQj/ZlszLYUcOPqaIwuLeSffOBrfUqIFEM/TqKUkOOAKvDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149506; c=relaxed/simple;
	bh=6RL1u9uAiu8DowHkYOLNevCkRFYw9BGRr4Ad9UxyGmE=;
	h=Message-ID:Date:MIME-Version:Cc:To:From:Subject:Content-Type; b=m50m23elOuyJcQWsnDe0bE606/Owe8qrO8oT5JJs4jfRzea6QRIO6CsE3gkAM+FCDoSLpccnkvFoYSlTUSWtqdKSTckwhXkoN5KJe68RRPL9003gBJQ7N+ud/IKum+L6xwx+8jnAe9hT848pfWcJc6mCtkitT8TIqfEim1iDqa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=ajJHD1qi; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726149493; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XCOvL3FPVJaz2kmlgdcecBR/k006eBoqIIxtQxomgMYBmG10t/FJE5PM1QZMmny8+d81R+CNweat9DbolkRnYkT0y+w9QleumjH0V0taqX98nI1A30ZonWOWEBAZlRsG0rxmvTgJxNUnKz7bqrlhehQ8Eu/Si09yrUFvFs2IJjM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726149493; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4XEnPE+y+6wafM93GCnUgLXvpskej0TCZhls/HUpw4M=; 
	b=B0p9wB8NDUSVcgFU5d+CZ0AlfFwDpIT3yvBjEv3ShG9GTXjwe/XenojWbbG4BowQS0i5gFI1R3+RejA5OgqcDmzJpdzef+96dvTU27/hqzyriwTfnIfGj9rDKRmBg9F24KBDMtGiROwym4k8QhgtIE2IFE8i/KXWgfYBJjUxWVc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726149493;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:To:To:From:From:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4XEnPE+y+6wafM93GCnUgLXvpskej0TCZhls/HUpw4M=;
	b=ajJHD1qiOZZkv+m+JnmsUUECA5aM8VzLWahaojydZYLymFcOlMlrerMio82yOXNj
	OiqCCAZvYTEtgAN8c1Ikrv41EXfP4v+csJb5kQvl9JakRyVRoj5q9G0+MAKsYhx6pqC
	QLIR7qt2QXgGiubwgvcX3XE+aDy+2YJ7CJx0BULI=
Received: by mx.zohomail.com with SMTPS id 1726149490487599.0968480854402;
	Thu, 12 Sep 2024 06:58:10 -0700 (PDT)
Message-ID: <d3468fce-088c-45d0-8543-a2bc9fef07c9@collabora.com>
Date: Thu, 12 Sep 2024 18:58:02 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, kernel@collabora.com,
 gustavo.padovan@collabora.com, helen.koike@collabora.com
Content-Language: en-US
To: Daniel Wagner <wagi@monom.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Bristot de Oliveira <bristot@kernel.org>
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
Subject: [Report] rtla: Failed to set runtime and/or period
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

We are running rt-tests on KernelCI. I'm looking at failures and I found
out that rtla osnoise and rtla timerlat are failing. We have just
enabled these tests and they are failing from day one.

The first thing I fixed in my local setup is to sync the version of rtla
with that of the running kernel from the source. It resolves the Tracer
timerlat not found!" error as we had installed the older rtla package
from Debian on CI. I'll update it. Is the version of rtla dependent on
the exact kernel version or any recent rtla version is acceptable?

The other errors are persistent:

➜  sudo ./rtla osnoise hist -r 900000
Failed to set runtime and/or period
Could not apply config

I thought maybe some argument are wrong. I ran the example from man page:

➜  sudo ./rtla osnoise hist -P F:1 -c 0-11 -r 900000 -d 1M -b 10 -E 25
Failed to apply CPUs config
Could not apply config

Is there some configuration which is missing for running rtla? Please
let me know.

-- 
BR,
Muhammad Usama Anjum

