Return-Path: <linux-kernel+bounces-577493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBBBA71DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5961889485
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067F123E33D;
	Wed, 26 Mar 2025 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+0jSa7c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C9F23E334;
	Wed, 26 Mar 2025 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011869; cv=none; b=TLz8atY25mzOg0J6MDaoCHuz37PK6wJ/AlzivDm2fskQLZMVgcv7GU6oqgyNwlJQjREiAnOPOJKlmXzmdD/O0TK3BFUX6xy/KFaJ91rIjWCLQ9moLBL9CzUXA+tRF9ahEZ8UnPYBQte/hhkOQ3uj1xlY+HVy77LS2l3K9Lww9sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011869; c=relaxed/simple;
	bh=GqOcnRFwlAHtp/aIMlSjsrauyIL3K6klyA2xEQOJUvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URrCfqwSYbMG/EfG12PoakzvY/M8W2aYLU6RLJ7GFwEf+LWukL4l7rHEYitmDVRxCB8gsDK9WwPwk2MHxAdXMzGYyg+pMrgRHDFDbKObU3jIRsXMAFQdnxPHoG5bjeCCkLY9Qii0tl3mfRHaw4HyjiOZhpJo3u/FRbuJhvPNJ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+0jSa7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D956DC4CEE9;
	Wed, 26 Mar 2025 17:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743011868;
	bh=GqOcnRFwlAHtp/aIMlSjsrauyIL3K6klyA2xEQOJUvk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b+0jSa7cZfR/1HhlQHIH8Zu8IxU8dTyf/ZW+W6v3rGedeJZ4hDz5p2Bii+DzH2RLP
	 bb/NCTZHuKmmkgPI7/MtOFSl1viIjaYeqEMsMp3WmUFPMnzdFAETzy4UYvBrYQVdn2
	 XNF/irI7SEjZJw9ICpKdZY+IFqxa22VXfw5XBPtFvLv+/vygOifc9u0va0lIPZKW7V
	 rS6GBdvW/Gy98o3zdE2VLAMFrSpDSZ5R+UZ3droT5tI1yubqF2JEZLi1EJ0iL83s8H
	 vqW97g5q2wGuuFC0bJo9voPX3zqr3eMDA+rU2SWDh4G6T3owCF/h0dx9I0qvcCp4oy
	 KUI73Y0qUCmDg==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72bbc03d436so101690a34.3;
        Wed, 26 Mar 2025 10:57:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAq/IDu6iiWytq0kU07PbK4Uh0hUlSEZ6eFEsNtpS/djWWo1vLzj+iLtKZJjHtKt8w4Nbm5HnNI/3ugzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhI5YoXEQhrO/bXEfzi/Feq/VPYAr7ie83tTAD/XcmGIyhrON/
	7tH9VDvYkokqalnOWrGsfE57xxQeO7Aa+7jn1t0KX6ZNd2uKMLSLxDzGI7B+On6y8hq/rKqTEPL
	bbHD3I870LtgYfHjA9RXIaAjqtTw=
X-Google-Smtp-Source: AGHT+IGt4eD2dTMMXBmq7kFDQ2GELUuv+zrkhHmxQU26TbdlWTVi8vwnmhmQbiKeeKP6QytrVdIEIhVN54F0jvDImK0=
X-Received: by 2002:a05:6830:3151:b0:72b:93c9:41a6 with SMTP id
 46e09a7af769-72c4c9f2c69mr441975a34.20.1743011868181; Wed, 26 Mar 2025
 10:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ1CgxEJn543x50SbvZQZCvSxUFB2xJ7OL3ejcgNqWr0=O52JQ@mail.gmail.com>
In-Reply-To: <CAJ1CgxEJn543x50SbvZQZCvSxUFB2xJ7OL3ejcgNqWr0=O52JQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Mar 2025 18:57:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hzLXt5P9VWw_DfmUop37Gju7qf5p5W20RPDWtCFH-yxw@mail.gmail.com>
X-Gm-Features: AQ5f1JoYRG2zv3xvwYfCHGdETN8jDDq7DPyIyz6dD4HUTunVXXto8_NbVHl56Dc
Message-ID: <CAJZ5v0hzLXt5P9VWw_DfmUop37Gju7qf5p5W20RPDWtCFH-yxw@mail.gmail.com>
Subject: Re: ACPI BIOS errors causing intermittent boot freezes on Lenovo
 Legion Pro 5
To: Dominik Pawlik <osemka59@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 6:36=E2=80=AFPM Dominik Pawlik <osemka59@gmail.com>=
 wrote:
>
> To: linux-acpi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Subject: ACPI BIOS errors causing intermittent boot freezes on Lenovo
> Legion Pro 5
>
> SYSTEM INFORMATION
>
> Hardware:
> - Laptop/Desktop Model: Lenovo Legion Pro 5 16IRX9 i9-14900HX
> - CPU: i9-14900HX
> - BIOS Version: N0CN29WW
>
> Kernel Version: 6.13.8-061308-generic #202503222044
> Distribution: Ubuntu 24.10
>
> OBSERVED ISSUE
>
> Description: System freezes intermittently during boot due to ACPI BIOS e=
rrors.

There are two things here, the ACPI error messages in the kernel log
and failing boot.  Do you actually know how these two things are
related to each other?

First, the same or similar messages are also present in your
successful boot log.  Second, there is nothing I can see that would
indicate a direct connection between those messages and boot failures.

> Errors indicate missing symbols (_TZ.ETMD,
> _SB.PC00.LPCB.EC0._Q37.PNOT, _Q38.PNOT)
> in ACPI tables.

True, but is this the reason for failing to boot?

> Error Logs:
> [13:40:52] kernel: ACPI Error: Aborting method \_SB.IETM._OSC due to
> previous error (AE_NOT_FOUND) (20240827/psparse-529)
> [13:40:52] kernel: ACPI BIOS Error (bug): Could not resolve symbol
> [\_TZ.ETMD], AE_NOT_FOUND (20240827/psargs-332)
> [13:40:21] kernel: ACPI: video: Video Device [GFX0] (multi-head: yes
> rom: no  post: no)
> [13:40:21] kernel: ACPI: video: Video Device [PEGP] (multi-head: yes
> rom: no  post: no)
> [13:40:21] kernel: ACPI Error: Aborting method \_SB.IETM._OSC due to
> previous error (AE_NOT_FOUND) (20240827/psparse-529)
> [13:40:21] kernel: ACPI BIOS Error (bug): Could not resolve symbol
> [\_TZ.ETMD], AE_NOT_FOUND (20240827/psargs-332)
> [13:40:21] kernel: ACPI BIOS Error (bug): Could not resolve symbol
> [\_SB.PC00.LPCB.EC0._Q37.PNOT], AE_NOT_FOUND (20240827/psargs-332)
> [13:40:21] kernel: ACPI Error: Aborting method \_SB.PC00.LPCB.EC0._Q38
> due to previous error (AE_NOT_FOUND) (20240827/psparse-529)
>
> Full boot logs available in:
> - boot_failed_journal.txt (failed boot case)
> - boot_succeeded_journal.txt (successful boot case)
> - acpidump.txt (ACPI tables)
>
> STEPS TO REPRODUCE
> 1. Reboot the system
> 2. Observe ACPI errors during boot (freezes occur intermittently,
> every few boots)
>
> TROUBLESHOOTING ATTEMPTED
> - Updated BIOS to latest version (N0CN29WW)
> - Tried booting without splash screen (nomodeset)
> - Tested with multiple kernel versions (including official)

