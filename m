Return-Path: <linux-kernel+bounces-392776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF719B97F9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36F21C215E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEA11CEE83;
	Fri,  1 Nov 2024 18:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="BYT+xvQk"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ADA2E62C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730487422; cv=none; b=GXh7Nz7rqMUzTnlKkfeJ+P/ttFnsLRUW1LURNMMzekEf0pvcyF8axUTLRCQxy7aTew/dhQqL6wGh1ZJuRxZZgcHSOR9Z9I7RKURQ9UbG7W8NCUJpyRRlsv3JcveTDU7n95025Z5SLdedckTypy+kytRUI3XQDVcFKIl4QGFToXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730487422; c=relaxed/simple;
	bh=p52J8VXMT6cJEL1h8lE9k3x4W/8+QgDVWMOGEi4v9pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOJwWwQXbpLlkQhSqQQLidwNX5G0PlOWktFc8w18XfzH1gh0kqU05xUGrl0xs7wHQJKAsVUzZreIRK7OcM5eNpWQpWHGZ3/ExVWhQpeo1RzgjYEBLKUDd5sKvjnagxm0eG4blTsA9gD/wElca8ST9QMs9pUXdyoTVUgMSFbIM6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=BYT+xvQk; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 221B41770C1; Fri,  1 Nov 2024 18:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1730487420; bh=p52J8VXMT6cJEL1h8lE9k3x4W/8+QgDVWMOGEi4v9pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BYT+xvQkKbroUzRMkOfKzsK64Id+PpDr87MXUkSSWZzuwFXFYuIfkF+PlBdD55yd/
	 Eh4q/gu9E5DUZySnOonncrNXzetrNAyUrc4lLBlkA/+s/uwO+n5iQm2FtLLhqRaO5y
	 Fmi1MboLs2AARB1VF5W3cJqpxATxn89LYRpoPpsTRgkT+VrJZmAiAMMbyL2yHfLWN3
	 065Y0k1IluRwtKYfi1vGhhkbq4GzDJgK5TbMvNkPmx9bIGhDrdIwmlaxq0jjXZlOMA
	 BePVW60qjZ9JidOGh40CzSyWmpR3C0bIDYNEilMMUNjUhJRK40tQRHkMf1g2bT5udv
	 iYbpvloqmKhvg==
Date: Fri, 1 Nov 2024 18:57:00 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>, jason.wessel@windriver.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: Fix incorrect naming of history arrow keys in code
Message-ID: <20241101185700.GA38961@lichtman.org>
References: <20241031192350.GA26688@lichtman.org>
 <CAD=FV=WC-ce14rgrYsVbg75dNX5tL6Saj5T8YqpAWm2ndLGdXA@mail.gmail.com>
 <20241101002612.GA29456@lichtman.org>
 <CAD=FV=V+EJf--J29YM7XuHbNO0fFzLgOYBhBA5VsnnMTG-LArQ@mail.gmail.com>
 <20241101183418.GB752705@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101183418.GB752705@aspen.lan>

On Fri, Nov 01, 2024 at 06:34:18PM +0000, Daniel Thompson wrote:
> On Fri, Nov 01, 2024 at 08:29:39AM -0700, Doug Anderson wrote:
> > On Thu, Oct 31, 2024 at 5:26 PM Nir Lichtman <nir@lichtman.org> wrote:
> > >
> > > On Thu, Oct 31, 2024 at 04:06:03PM -0700, Doug Anderson wrote:
> > > > >
> > > > > kdb doesn't react to ctrl p and n, and following the code flow with GDB
> > > > > reveals that these values map to the up and down arrows.
> > > >
> > > > Really? kdb reacts to "ctrl-P" and "ctrl-N" for me. It also reacts to
> > > > "ctrl-F" and "ctrl-B".
> > > >
> > >
> > > Interesting, how do you run kdb? I use the kgdboc=kbd kernel boot param.
> > > I haven't checked with serial as the console since I work with the keyboard,
> > > but if serial does go through this using ctrl+p/n then the code in the
> > > current state is misleading since the keys change depending on the I/O method.
> >
> > > Evidence in the code for usage of arrow keys in the case of keyboard can
> > > be seen by examining kdb_read in kernel/debug/kdb/kdb_io.c, in the /* Down */
> > > and /* Up */ cases the values 14 and 16 can be seen.
> >
> > Right. Essentially the logic is converting the Up and Down sequences
> > to the characters Ctrl-P and Ctrl-N. ...so by the time we get to
> > handle_ctrl_cmd() the characters really are Ctrl commands, not arrow
> > commands. Thus handle_ctrl_cmd() is correct as is.
> 
> Those comments, which I'm pretty sure I added, are arguably more a
> reminder about how the input systems map up/down (which on serial are
> multi-byte escape sequences) into single character control codes.
> 
> 
> > > Do you suggest to keep as is or to work on a patch with a more generic name that
> > > would fit both?
> >
> > IMO it's a bug that the keyboard code isn't properly reporting Ctrl-N
> > and Ctrl-P. Does it handle other Ctrl characters? Ctrl-A should go to
> > the start of the line and Ctrl-E the end. Maybe you can track down why
> > this isn't happening?
> 
> I'm with Doug on this one. What values does the kdb code generate
> Ctrl-<letter>? IMHO it should be generating 14 for ctrl-N and 16 for
> ctrl-P.
> 
> BTW ctrl-N and ctrl-P are very common keystrokes for command line
> history (try them in any readline program such as bash).
> 

Hi Doug and Daniel,

In the current state using KDB in keyboard mode doesn't react to expected
CTRL chords such as CTRL+N/P/A/E, but does react to arrow keys,
Following this, I have also inspected the serial mode and over there I see
that both arrows and CTRL chords work.
From what I understand going forward, the best solution would be to add support
for the CTRL chords in the keyboard mode as well to be in line with serial?

BTW I originally wanted to add support also for CTRL+U and CTRL+W what is your
opinion about that as a feature as well?

Thanks,
Nir

